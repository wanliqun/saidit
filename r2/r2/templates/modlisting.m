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

<%namespace file="printablebuttons.m" import="ynbutton" />
<%namespace file="userlisting.m" import="add_form, listing"/>
<%namespace file="utils.m" import="error_field"/>

<div class="${thing._class} usertable">
  %if thing.can_remove_self:
      ${ynbutton(op='unfriend',
                 title=_("leave"),
                 executed=_("you are no longer a moderator"),
                 question=_("stop being a moderator?"),
                 format=_('you are a moderator of this sub. %(action)s'),
                 format_arg='action',
                 _class=thing.type + ' remove-self',
                 hidden_data=dict(
                   id=c.user._fullname,
                   type=thing.type,
                   container=thing.container_name),
                 access_required=False)}
  %endif

  %if thing.has_invite:
    ${ynbutton(op='accept_moderator_invite',
               title=_("accept"),
               executed=_("you are now a moderator. welcome to the team!"),
               question=_("become a moderator of %s?" % ("/" + g.brander_community_abbr + "/" + c.site.name)),
               format=_('you are invited to become a moderator. %(action)s'),
               format_arg='action',
               _class=thing.type + ' accept-invite',
               access_required=False)}
  %endif

  %if thing.addable and thing.has_add_form:
    <%call expr="add_form(thing.form_title, thing.destination, thing.type, thing.container_name, verb=_('add'))">
      ${error_field("ALREADY_MODERATOR", "name")}
      ${error_field("BANNED_FROM_SUBREDDIT", "name")}
      ${error_field("MUTED_FROM_SUBREDDIT", "name")}
    </%call>
  %endif
  ${listing()}
</div>
