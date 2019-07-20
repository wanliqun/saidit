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
  from r2.lib import js
  from r2.lib.strings import strings
%>

<%namespace file="utils.m" import="error_field, _md"/>
<%namespace name="utils" file="utils.m"/>


% if c.user_is_loggedin and c.user.name in g.admins:
<h1>${_("two-factor authentication")}</h1>

    % if c.user.otp_secret:
    <form action="/post/disable_otp" method="post" onsubmit="return post_form(this, 'disable_otp')" id="pref-otp">

    ${_md("two-factor authentication is currently **enabled**. fill out the form below if you would like to disable it.", wrap=True)}

    <%utils:round_field title="${_('password')}" description="${_('(required)')}">
      <input type="password" name="password" />
      ${error_field("WRONG_PASSWORD", "password")}
    </%utils:round_field>

    <%utils:round_field title="${_('one-time password')}" description="${_('(required)')}">
      <input type="number" name="otp" maxlength="6" />
      ${error_field("WRONG_PASSWORD", "otp")}
      ${error_field("NO_OTP_SECRET", "otp")}
      ${error_field("RATELIMIT", "otp")}
    </%utils:round_field>

    <input type="submit" value="${_("disable")}">
    </form>
    % else:
    <form action="/post/generate_otp_secret" method="post" onsubmit="return post_form(this, 'generate_otp_secret')" id="pref-otp">

    ${_md("enter your current password below to start the activation process for two-factor authentication.", wrap=True)}

    <%utils:round_field title="${_('password')}" description="${_('(required)')}">
      <input type="password" name="password" />
      ${error_field("WRONG_PASSWORD", "password")}
    </%utils:round_field>

    <input type="submit" value="${_("activate")}">

    </form>

    <form action="/post/enable_otp" method="post" onsubmit="return post_form(this, 'enable_otp')" id="pref-otp-qr">

    <div id="otp-secret-info">
        ${_md("below is your two-factor authentication secret. you can scan the QR code with Google Authenticator or enter the key below manually. you WILL NOT have another chance to see this secret.")}
    </div>

    <%utils:round_field title="${_('one-time password')}" description="${_('(required)')}">
      <input type="number" name="otp" maxlength="6" />
      ${error_field("WRONG_PASSWORD", "otp")}
      ${error_field("EXPIRED", "otp")}
    </%utils:round_field>

    <input type="submit" value="${_("enable")}">

    </form>
    % endif
% endif

${unsafe(js.use("qrcode"))}
