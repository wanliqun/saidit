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

<h1>${_("give creddits to a user")}</h1>

<form id="creddits" action="/api/givecreddits" method="post" class="pretty-form medium-text"
      onsubmit="return post_form(this, 'givecreddits');">

  <table class="lined-table borderless">
    <tr>
      <td>${_("recipient")}</td>
      <td>
        <input type="text" name="recipient" value="${thing.recipient}">
        ${error_field("NO_USER", "recipient", "span")}
        ${error_field("USER_DOESNT_EXIST", "recipient", "span")}
      </td>
    </tr>
    <tr>
        <td>${_("creddits")}</td>
      <td>
        <input type="number" name="num_creddits">
        ${_("(negative to take away)")}
      </td>
    </tr>
  </table>

  <button class="btn" type="submit">${_("give")}</button>

  <span class="status"></span>
</form>

