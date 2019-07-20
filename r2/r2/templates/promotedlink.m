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
   from r2.lib.filters import conditional_websafe
   from r2.lib.promote import promo_edit_url
   from r2.lib import promote
   from r2.lib.pages.things import LinkButtons
   from r2.lib.pages import WrappedUser
%>

<%inherit file="link.m"/>
<%namespace file="printablebuttons.m" import="ynbutton" />
<%namespace file="utils.m" import="plain_link" />
<%namespace file="promotelinkedit.m" import="campaign_list" />

<%def name="tagline()">
<%
   if (c.user_is_sponsor or thing.is_author) and not promote.is_promoted(thing):
     taglinetext = _("to be promoted by %(author)s") 
   else:
     taglinetext = _("promoted by %(author)s") 
   taglinetext = conditional_websafe(taglinetext).replace(" ", "&#32;")
   author = WrappedUser(thing.author, thing.attribs, thing,
                        force_show_flair=False).render()
 %>
${unsafe(taglinetext % dict(author=author))}
</%def>

<%def name="buttons(comments=True, delete=True, report=True, additional='')">
  ${LinkButtons(thing, 
                comments = not getattr(thing, "disable_comments", False), 
                delete = delete, 
                report = report)}
</%def>

<%def name="domain()">
  %if not thing.is_self:
    ${parent.domain(link=False)}
  %endif
</%def>

<%def name="entry()">
  ${parent.entry()}
  <p class="sponsored-tagline">
    %if thing.is_author or c.user_is_sponsor:
      %if not promote.is_promo(thing):
        ${_('deleted sponsored link')}
      %elif promote.is_unpaid(thing):
        ${_('unpaid sponsored link')}
      %elif promote.is_unapproved(thing):
        ${_('waiting approval')}
      %elif promote.is_rejected(thing):
        ${_('rejected sponsored link')}
      %elif promote.is_promoted(thing):
        ${_('sponsored link')}
      %elif promote.is_accepted(thing):
        ${_('accepted sponsored link')}
      %elif promote.is_edited_live(thing):
        ${_('edited live sponsored link')}
      %endif
    %else:
      ${_('sponsored link')}
    %endif
  </p>

  %if getattr(thing, "show_campaign_summary", False):
  <div class="campaign-detail">
    ${campaign_list()}
  </div>
  %endif
</%def>

