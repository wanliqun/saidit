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

<%namespace file="utils.m" import="inline_radio_type, md"/>

<div class="titlebox">
  <div class="server-seconds rounded">
    %if thing.message:
      ${md(thing.message)}
    %endif

    %if thing.gift_message:
      ${md(thing.gift_message)}
    %endif

    %if thing.is_user:
    <div class="server-seconds-public bottom">
      <div class="title">${_("visible to:")}</div>
      <form id="seconds_visibility_form">
        ${inline_radio_type("seconds_visibility", "private", _("only me"), checked=not thing.is_public)}
        ${inline_radio_type("seconds_visibility", "public", _("everyone"), checked=thing.is_public)}
      </form>
      <div class="note">${_('note: you will only be eligible for a gilding trophy if this is set to "everyone"')}</div>
    </div>
    %endif
  </div>
</div>

<script type="text/javascript">
  $('[name="seconds_visibility"]').click(
    function () {
      var form = $('#seconds_visibility_form');
      post_form(form, 'server_seconds_visibility');
    }
  ) 
</script>
