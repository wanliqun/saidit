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
  from r2.lib.template_helpers import static 
%>

<%namespace file="utils.m" import="submit_form, _md, _mdf"/>
<%namespace name="utils" file="utils.m"/>

<%inherit file="interstitial.m"/>

<%def name="interstitial_image_attrs()">
  src="${static('interstitial-image-quarantine.png')}"
  alt="${_('quarantined')}"
</%def>

<%def name="interstitial_title()">
  %if thing.can_opt_in:
    ${_("Are you sure you want to view this community?")}
  %elif thing.logged_in:
    ${_md("You must have a [verified email](/prefs/update) to view this community")}
  %else:
    ${_("You must log in and have a verified email to view this community")}
  %endif
</%def>

<%def name="interstitial_message()">
  <p>
    <%
      quarantine_link = 'https://reddit.zendesk.com/hc/en-us/articles/205701245'
    %>

    %if thing.can_opt_in:
      ${_mdf("Communities that are dedicated to shocking or highly offensive content are [quarantined](%(link)s). Content in this community may be upsetting. Are you certain you want to continue?", link=quarantine_link)}
    %else:
      ${_mdf("Communities that are dedicated to shocking or highly offensive content are [quarantined](%(link)s).", link=quarantine_link)}
    %endif
  </p>
</%def>

<%def name="interstitial_buttons()">
  %if thing.can_opt_in:
    <%utils:submit_form _class="pretty-form">
      <input type="hidden" name="sr_name" value="${thing.sr_name}" />

      <div class="buttons">
        <button class="c-btn c-btn-primary" type="submit" name="accept" value="no">
          ${_("no thank you")}
        </button>
        <button class="c-btn c-btn-primary" type="submit" name="accept" value="yes">
          ${_("continue")}
        </button>
      </div>
    </%utils:submit_form>
  %else:
    ${parent.interstitial_buttons()}
  %endif
</%def>
