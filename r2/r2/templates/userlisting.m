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
   from r2.lib.template_helpers import format_html
 %>
<%namespace file="utils.m" import="error_field, plain_link" />

<%def name="add_form(title, dest, add_type, container_name, verb=None, permissions_form=None)">
  <form action="/post/${dest}"
        method="post" class="pretty-form medium-text friend-add"
        onsubmit="return post_form(this, '${dest}')"
        id="${add_type}">
    <h1>${title}</h1>

    <input type="hidden" name="action" value="add">
    <input type="hidden" name="container" value="${container_name}">
    <input type="hidden" name="type" value="${add_type}">
    %if add_type in ("banned", "wikibanned"):
        <label for="name">${_('who to ban?')} &nbsp;</label>
        <input type="text" class="friend-name" name="name" id="name">
        <div>
        %if feature.is_enabled("subreddit_rules", subreddit=c.site.name):
          <label for="ban_reason">${_("reason")}</label>
          <select name="ban_reason">
            %if thing.rules:
              <optgroup label="Subreddit Rules">
                %for rule in thing.rules:
                  <option value="${rule['short_name']}">${rule['short_name']}</option>
                %endfor
              </optgroup>
            %endif
            <optgroup label="Site Rules">
              %for rule in thing.system_rules:
                <option value="${rule}">${rule}</option>
              %endfor
            </optgroup>
            <option value="other">${_("Other")}</option>
          </select>
        %endif
          <div>
            <label for="note">${_("mod note")}
            <input type="text" maxlength="300" name="note" id="note">
            <span>${_('(will not be visible to user)')}</span>
          </div>
        </div>
        <div>
            <label for="duration">${_('how long?')}</label>
            <input type="number" min="1" max="999" name="duration" id="duration">
            <span>${_('days (leave blank for permanent)')}</span>
        </div>
    %elif add_type == "muted":
        <label for="name">${_('who to mute?')} &nbsp;</label>
        <input type="text" class="friend-name" name="name" id="name">
        <div>
            <label for="note">${_('why the mute?')}</label>
            <input type="text" maxlength="300" name="note" id="note">
            <span>${_('(will not be visible to user)')}</span>
        </div>
    %else:
        <input type="text" name="name" id="name">
    %endif
    %if add_type == "banned":
      <div>
          <label for="note">${_('note to include in ban PM')}</label>
          <textarea name="ban_message" id="ban_message"></textarea>
      </div>
    %endif
    %if permissions_form:
      ${permissions_form}
      &#32;
      <span class="permissions-edit">
        (<a href="javascript:void(0)">${_('change')}</a>)
      </span>
    %endif
    <button class="btn" type="submit">${verb or _("add")}</button>
    <span class="status"></span>
    ${error_field("NO_USER", "name")}
    ${error_field("USER_DOESNT_EXIST", "name")}
    ${error_field("ALREADY_MODERATOR", "name")}
    ${error_field("CANT_RESTRICT_MODERATOR", "name")}
    ${error_field("BANNED_FROM_SUBREDDIT", "name")}
    ${error_field("MUTED_FROM_SUBREDDIT", "name")}
    %if caller:
      ${caller.body()}
    %endif
  </form>
</%def>

<%def name="listing()">
  <div class="${thing.type}-table"
    style="${'display:none' if not thing.things and not thing.show_not_found else ''}">
    <h1>
      ${thing.title}
    </h1>

    <table>
      %if thing.headers:
        <tr>
        %for header in thing.headers:
            <th>${header}</th>
        %endfor
        </tr>
        %endif
        %if thing.things:
            %for item in thing.things:
                ${item}
            %endfor
        %else:
        <tr class="notfound"><td>${_('No items found') if thing.show_not_found else ''}</td></tr>
      %endif
    </table>
  </div>

%if thing.nextprev and (thing.prev or thing.next):
  <p class="nextprev"> ${_("view more:")}&#32;
  %if thing.prev:
    ${plain_link(_("first"), thing.first, rel="nofollow first")} 
    <span class="separator"></span>
    ${plain_link(format_html("&lsaquo; %s", _("prev")), thing.prev, rel="nofollow prev")}
  %endif
  %if thing.prev and thing.next:
    <span class="separator"></span>
  %endif
  %if thing.next:
  ${plain_link(format_html("%s &rsaquo;", _("next")), thing.next, rel="nofollow next")}
  %endif
  </p>
%endif

</%def>

<div class="${thing._class} usertable">
  %if thing.addable and thing.has_add_form:
    ${add_form(thing.form_title, thing.destination, thing.type, thing.container_name, permissions_form=thing.permissions_form)}
  %endif

  %if thing.show_jump_to:
    <h1>${_('jump to')}</h1>
    <form class="pretty-form medium-text">
        <label for="user">${_('username')}&nbsp;</label>
        <input type="text" id="user" name="user"
        %if thing.jump_to_value:
            value="${thing.jump_to_value}"
        %endif
        >
        <button type="submit">${_('go')}</button>
    </form>
  %endif

${listing()}

%if thing.jump_to_value:
    <p class="nextprev">
        ${plain_link(_("show all"), request.path, rel="nofollow")}
    </p>
%endif

</div>
