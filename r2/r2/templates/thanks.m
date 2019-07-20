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

<%namespace file="utils.m" import="error_field, radio_type"/>
<%namespace name="utils" file="utils.m"/>

<%! from r2.lib.strings import strings %>

<form id="thanks" action="/api/claimgold" method="post"
      class="content"
      onsubmit="return post_form(this, 'claimgold');">
%if thing.status == "creddits":
  <h1>${_("thanks for buying creddits!")}</h1>
%else:
  <h1>${_("thanks for subscribing!")}</h1>
%endif

<p class="blurb">
%if thing.status == "creddits":
  ${_("enter your confirmation code below to claim your gift creddits")}
%elif thing.status == "mundane":
  ${_("enter your confirmation code below to activate reddit gold")}
%else:
  ${_("You're already a reddit gold subscriber.")}
  &#32;
  ${_("But if you just gave us even more money, enter the new confirmation code below and we'll add the extra credit to your account.")}
</p>
%endif

<div class="spacer">
  <%utils:round_field title="">
    <input type="text" name="code" value="${thing.secret}" />
    ${error_field("INVALID_CODE", "code")}
    ${error_field("CLAIMED_CODE", "code")}
    ${error_field("NO_TEXT", "code")}
  </%utils:round_field>
</div>

<button type="submit" class="btn">${_("claim")}</button>
</form>
