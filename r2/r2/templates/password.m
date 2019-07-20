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

<%namespace file="utils.m" import="error_field"/>
<%namespace name="utils" file="utils.m"/>

<form id="passform" action="/api/password" method="post"
      class="content"
      onsubmit="return post_form(this, 'password');">
  <h1>${_("reset your password")}</h1>
  <p>${_("enter your username below and we'll email you a link to reset your password")}</p>
  %if request.params.get('expired'):
    <span class="error">
      ${_("password reset link expired. please try again")}
    </span>
  %endif

<div class="spacer">
  <%utils:round_field title="${_('username')}">
    <input type="text" name="name" maxlength="20"/>
    ${error_field("USER_DOESNT_EXIST", "name")}
    ${error_field("NO_EMAIL_FOR_USER", "name")}
    ${error_field("RATELIMIT", "ratelimit")}
  </%utils:round_field>
</div>

<button type="submit" class="btn">${_("email me")}</button>
<span class="status"></span>

</form>

