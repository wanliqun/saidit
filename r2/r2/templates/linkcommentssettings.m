## The contents of this file are subject to the Common Public Attribution
## License Version 1.0. (the "License"); you may not use this file except in
## compliance with the License. You may obtain a copy of the License at
## http://code.reddit.com/LICENSE. The License is based on the Mozilla Public
## License Version 1.1, but Sections 14 and 15 have been added to cover use of
## software over a computer network and provide for limited attribution for the
## Original Developer. In addition, Exhibit A has been modified to be
## consistent with Exhibit B.
##
## Software distributed under the License is distributed on an "AS IS" basis,
## WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
## the specific language governing rights and limitations under the License.
##
## The Original Code is reddit.
##
## The Original Developer is the Initial Developer.  The Initial Developer of
## the Original Code is reddit Inc.
##
## All portions of the code written by reddit are Copyright (c) 2006-2015
## reddit Inc. All Rights Reserved.
###############################################################################

<%!
  from r2.config import feature
  from r2.lib.filters import jssafe
%>

<%namespace file="printablebuttons.m" import="ynbutton" />


<%def name="suggested_clear_type(name, value=None)">
  <a href="javascript:void(0)"
     onclick="return set_suggested_sort(this, '${jssafe(value or name)}')">${_(name)}</a>
</%def>

<%def name="clear_suggested_sort()">
  <li class="toggle">
    <form method="post" action="/api/set_suggested_sort">
      <input type="hidden" name="id" value="${thing.link._fullname}" />
      <input type="hidden" name="sort" value="" />
      <input type="hidden" value="${_('suggested sort cleared')}" name="executed"/>
      <a href="javascript:void(0)"
         onclick="return toggle_clear_suggested_sort(this)"
         data-event-action="unsetsuggestedsort">
        ${_("clear suggested sort")}</a>
      <span class="option error">
         ${_("clear suggested sort?")}

         %if thing.sr.suggested_comment_sort:

           &#32;
           ## Set to explicitly "blank", which will disallow using the subreddit setting and use the user's setting
           ${suggested_clear_type('clear', 'blank')}
           &#32;/

           ## Show "use subreddit setting" only if a link's suggested sort is explicitly set
           %if thing.link.suggested_sort is not None:
           &#32;
           ## Set back to default, which will be the subreddit's suggested sort
           ${suggested_clear_type('use subreddit setting', '')}
           &#32;/
           %endif

         %else:

           &#32;
           ## Set back to "default" in case they explicitly set a subreddit suggested sort in the future
           ${suggested_clear_type('clear', '')}
           &#32;/

         %endif

         &#32;
         <a href="javascript:void(0)"
            onclick="return toggle_clear_suggested_sort(this)">${_('cancel')}</a>
         &#32;
      </span>
    </form>
  </li>
</%def>

%if thing.can_edit:
  %if thing.suggested_sort == thing.sort:
    <% clear_suggested_sort() %>
  %else:
    ${ynbutton(_("set as suggested sort"), _("suggested sort set"), "set_suggested_sort",
      hidden_data=dict(id=thing.link._fullname, sort=thing.sort),
      event_target='link', event_action='setsuggestedsort')}
  %endif
%endif

%if thing.is_author:
  %if thing.sendreplies:
    ${ynbutton(_("disable inbox replies"), _("inbox replies disabled"), "sendreplies",
      hidden_data=dict(id=thing.link._fullname, state=False),
      access_required=False, event_action="disable_inbox_replies")}
  %else:
    ${ynbutton(_("enable inbox replies"), _("inbox replies enabled"), "sendreplies",
      hidden_data=dict(id=thing.link._fullname, state=True),
      access_required=False, event_action="enable_inbox_replies")}
  %endif
  &nbsp;<span class="help-hoverable" title="${_('inbox replies will send you a message when this link receives a new top-level comment')}">(?)</span>
%endif

%if thing.can_edit:
  %if thing.contest_mode:
    ${ynbutton(_("disable contest mode"), _("contest mode disabled"), "set_contest_mode",
      hidden_data=dict(id=thing.link._fullname, state=False),
      event_target='link', event_action='unsetcontestmode')}
  %else:
    ${ynbutton(_("enable contest mode"), _("contest mode enabled"), "set_contest_mode",
      hidden_data=dict(id=thing.link._fullname, state=True),
      event_target='link', event_action='setcontestmode')}
  %endif
%endif

%if thing.can_sticky:
  %if thing.stickied:
    ${ynbutton(_("remove announcement"), _("removed"), "set_subreddit_sticky",
      hidden_data=dict(id=thing.link._fullname, state=False),
      event_target='link', event_action='unsticky')}
  %elif thing.stickies_full:
    ${ynbutton(_("make announcement"), _("announced"), "set_subreddit_sticky",
      question=_("make announcement? (bottom announcement will be replaced)"),
      hidden_data=dict(id=thing.link._fullname, state=True),
      event_target='link', event_action='sticky')}
  %else:
    ${ynbutton(_("make announcement"), _("announced"), "set_subreddit_sticky",
      question=_("make announcement?"),
      hidden_data=dict(id=thing.link._fullname, state=True),
      event_target='link', event_action='sticky')}
  %endif
%endif

%if thing.contest_mode:
  <div class="contest-mode infobar mellow"><strong>${_("this thread is in contest mode")}</strong>&#32;- 
  %if thing.can_edit:
    ${_('as a mod, you can sort comments however you wish and scores are visible. regular users have randomized sorting and cannot see the scores.')}
  %else:
    ${_('contest mode randomizes comment sorting, hides scores, and collapses replies by default.')}
  %endif
  </div>
%endif
