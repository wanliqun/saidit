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
   from r2.lib.filters import unsafe, safemarkdown, keep_space
   from r2.lib.strings import strings
   from r2.lib.utils import randstr

   ### CUSTOM
   from r2.config import feature
%>

<%namespace file="printablebuttons.m" import="toggle_button" />
<%namespace file="utils.m" import="data, error_field, md, _md"/>

<%def name="markhelp(show_embed_help=False)">
  <div class="markhelp" style="display:none">
    <p>${md(strings.formatting_help_info)}</p>
    <table class="md">
      <tr style="background-color: #ffff99; text-align: center">
        <td><em>${_( "you type:")}</em></td>
        <td><em>${_( "you see:")}</em></td>
      </tr>
      <tr>
        <td>*${_( "italics")}*</td>
        <td><em>${_( "italics")}</em></td>
      </tr>
      <tr>
        <td>**${_( "bold")}**</td>
        <td><b>${_( "bold")}</b></td>
      </tr>
      <tr>
        <td>[${g.brander_site}](${g.https_endpoint})</td>
        <td><a href="${g.https_endpoint}">${g.brander_site}</a></td>
      </tr>
      <tr>
        <td>
          * ${_( "item")} 1<br/>
          * ${_( "item")} 2<br/>
          * ${_( "item")} 3
        </td>
        <td>
          <ul>
            <li>${_( "item")} 1</li>
            <li>${_( "item")} 2</li>
            <li>${_( "item")} 3</li>
          </ul>
        </td>
      </tr>
      <tr>
        <td>&gt; ${_( "quoted text")}</td>
        <td><blockquote>${_( "quoted text" )}</blockquote></td>
      </tr>
      <tr>
          <td>
              Lines starting with four spaces <br/>
              are treated like code:<br/><br/>
              <span class="spaces">
                  &nbsp;&nbsp;&nbsp;&nbsp;
              </span>
              if 1 * 2 &lt; 3:<br/>
              <span class="spaces">
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              </span>
              print "hello, world!"<br/>
          </td>
          <td>Lines starting with four spaces <br/>
              are treated like code:<br/>
              <pre>if 1 * 2 &lt; 3:<br/>&nbsp;&nbsp;&nbsp;&nbsp;print "hello,
              world!"</pre>
          </td>
      </tr>
      <tr>
          <td>~~strikethrough~~</td>
          <td><strike>strikethrough</strike></td>
      </tr>
      <tr>
          <td>super^script</td>
          <td>super<sup>script</sup></td>
      </tr>
      <tr>
        <td>
          1.  <br/>
          7. <br/>
          4. 
        </td>
        <td>
          <ul>
            1. <br/>
            2. <br/>
            3.
          </ul>
        </td>
      </tr>
      <tr>
        <td>
          1\. <br/>
          7\. <br/>
          4\.
        </td>
        <td>
          <ul>
            1. <br/>
            7. <br/>
            4.
          </ul>
        </td>
      </tr>
      % if show_embed_help:
      <tr>
          <td>${_md('Links on their own line will be embedded:\n\nhttps://example.com')}</td>
          <td>${_('an embedded version of that link')}</td>
      </tr>
      % endif
    </table>
  </div>
</%def>

<%def name="action_button(name, btn_type, onclick, display)">
  <button type="${btn_type}" onclick="${onclick}" class="${name}"
          ${"style='display:none'" if not display else ""}>
    ${name}
  </button>
</%def>

%if thing.have_form:
  <form action="#" class="${thing.css_class} warn-on-unload"
      %if thing.post_form:
        onsubmit="return post_form(this, '${thing.post_form}')"
      %endif
        ${"style='display:none'" if not thing.display else ""}
        id="form-${thing.fullname + randstr(3)}">
%else:
  <div class="${thing.css_class}">
%endif

  ##this is set for both editting selftext and creating new comments
  <input type="hidden" name="thing_id" value="${thing.fullname}"/>

  %if thing.source:
    <input type="hidden" name="source" value="${thing.source}">
  %endif

  % if not thing.creating:
    <div class="usertext-body may-blank-within md-container ${'admin_takedown' if thing.admin_takedown else ''}">
      % if not thing.expunged:

        ## CUSTOM
        % if thing.is_chat_post and thing.user_chat_enabled and thing.chat_client == 'kiwiirc':
          % if thing.chat_user_is_guest:
            <iframe class="chat-iframe kiwiirc" src="${thing.chat_client_url}/?nick=${thing.chat_user}|?#${thing.chat_channel}"></iframe>
          % else:
            <iframe class="chat-iframe kiwiirc" src="${thing.chat_client_url}/?nick=${thing.chat_user}#${thing.chat_channel}"></iframe>
          % endif

        % elif thing.is_chat_post and thing.user_chat_enabled and thing.chat_client == 'thelounge':
          % if thing.chat_user_is_guest:
            <iframe class="chat-iframe thelounge" src="${thing.chat_client_url}/?tls=true&nofocus&lockchannel&autologin&user=${thing.chat_client_user}&autoconnect&nick=${thing.chat_user}&username=${thing.chat_user}&realname=${thing.chat_user}&join=${thing.chat_channel}"></iframe>
          % else:
            <iframe class="chat-iframe thelounge" src="${thing.chat_client_url}/?tls=true&nofocus&lockchannel&autologin&user=${thing.chat_client_user}&al-password=${thing.chat_client_password}&autoconnect&nick=${thing.chat_user}&username=${thing.chat_user}&realname=${thing.chat_user}&join=${thing.chat_channel}"></iframe>
          % endif

        % else:
          ${unsafe(safemarkdown(thing.text, nofollow = thing.nofollow,
                                        target = thing.target))}
        % endif
      % else:
        <em>${_("[removed]")}</em>&#32;
      % endif
    </div>
  %endif

  %if thing.editable or thing.creating:
    ##keep this on one line so we don't add extra spaces
    <div class="usertext-edit md-container"
         style="${"" if thing.creating else 'display: none'}">
      <div class="md">
        <textarea rows="1" cols="1"
                  name="${thing.name}"
                  class="${thing.textarea_class}"
                  ${data(**thing.data_attrs)}
                  >${keep_space(thing.text)}</textarea>
      </div>

      <div class="bottom-area">
        ${toggle_button("help-toggle", _("formatting help"), _("hide help"),
                        "helpon", "helpoff",
                         style = "" if thing.creating else "display: none")}

        <a href="/s/SaidIt/comments/j1/the_saiditnet_terms_and_content_policy/" class="reddiquette" target="_blank" tabindex="100">${_('content policy')}</a>

        %if thing.include_errors:
          ${error_field("TOO_LONG", thing.name, "span")}
          ${error_field("RATELIMIT", "ratelimit", "span")}
          ${error_field("NO_TEXT", thing.name, "span")}
          ${error_field("TOO_OLD", "parent", "span")}
          ${error_field("THREAD_LOCKED", "parent", "span")}
          ${error_field("DELETED_COMMENT", "parent", "span")}
          ${error_field("USER_BLOCKED", "parent", "span")}
          ${error_field("USER_MUTED", "parent", "span")}
          ${error_field("MUTED_FROM_SUBREDDIT", "parent", "span")}
        %endif
        <div class="usertext-buttons">
          ${action_button("save", "submit", "",
                          thing.creating and thing.have_form)}
          ${action_button("cancel", "button", "return cancel_usertext(this);", False)}
          %if thing.have_form:
            <span class="status"></span>
          %endif
        </div>
      </div>

      ${markhelp(show_embed_help=thing.show_embed_help)}
    </div>
  %endif

%if thing.have_form:
  </form>
%else:
  </div>
%endif

