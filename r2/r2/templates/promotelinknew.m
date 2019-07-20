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
%>

<%namespace file="promotelinkbase.m" import="title_field, content_field, managed_field, image_field" />
<%namespace file="utils.m" import="error_field" />
<%namespace name="utils" file="utils.m"/>

${unsafe(js.use('sponsored'))}

<div class="create-promotion sponsored-page">
  <div class="dashboard">
    <header>
      <h2>new promotion</h2>
    </header>
    <div class="dashboard-content">
      <div class="pretty-form promotelink-editor editor" id="promo-form">
        ## need to set the modhash because we're not using a helper method to post the form
        <input type="hidden" name="uh" value="${c.modhash}">
        <input type="hidden" name="id" value="#promo-form">
        <div class="editor-group">
          ${image_field(images=thing.images)}
          %if c.user_is_sponsor:
            ${username_field()}
            ${managed_field(None)}
          %endif
          ${title_field(None)}
          ${content_field(None, enable_override=c.user_is_sponsor,
                          tracker_access=c.user_can_track_ads)}
          <footer class="buttons">
            <div class="rules">
              By clicking "next" you agree to the&#32;<a href="http://www.reddit.com/wiki/selfserve#wiki_online_self_serve_advertising_rules" target="_blank">Self Serve Advertising Rules.</a>
            </div>
            ${error_field("RATELIMIT", "ratelimit")}
            &#32;
            <span class="status error"></span>
            ${error_field("RATELIMIT", "ratelimit")}
            <button
                name="create" class="btn primary-button" type="button"
                onclick="return post_pseudo_form('#promo-form', 'create_promo')">
              ${_("next")}
            </button>
          </footer>
        </div>
      </form>
      <iframe src="about:blank" width="600" height="200" 
              style="display: none;"
              name="upload-iframe" id="upload-iframe"></iframe>
    </div>
  </div>
</div>

<%def name="username_field()">
  <%utils:line_field title="${_('create as user')}" id="username-field" css_class="rounded">
    <input id="username" name="username" type="text" 
           class="rounded">
    ${error_field("NO_EMAIL_FOR_USER", "username", "div")}
    ${error_field("NO_VERIFIED_EMAIL", "username", "div")}
    ${error_field("USER_DOESNT_EXIST", "username", "div")}
    <div class="infotext rounded">
      <p>${_("Create a promotion on another user's account.")}</p>
    </div>
  </%utils:line_field>
</%def>

<script type="text/javascript">
  $(function() {
    r.sponsored.initUploads();
  });
</script>
