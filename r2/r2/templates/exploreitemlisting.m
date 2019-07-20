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
   from r2.lib.template_helpers import format_html
%>
<%namespace file="utils.m" import="plain_link" />
<%
   _id = ("_%s" % thing.parent_name) if hasattr(thing, 'parent_name') else ''
   cls = "exploreitemlisting"
 %>

<div id="siteTable${_id}" class="sitetable ${cls}">
  <div class="explore-header">
    <span id="explore-settings">
      <form method="POST" action="/post/explore_settings">
        <input type="hidden" name="uh" value="${c.modhash}">
        <span>
          <input type="checkbox" name="pers" value=1 ${"checked" if thing.settings.personalized else ""}>
            ${_("personalized")}
          </input>
          <input type="checkbox" name="disc" value=1 ${"checked" if thing.settings.discovery else ""}>
            ${_("discovery")}
          </input>
          <input type="checkbox" name="ris" value=1 ${"checked" if thing.settings.rising else ""}>
            ${_("rising")}
          </input>
          <input type="checkbox" name="nsfw" value=1 ${"checked" if thing.settings.nsfw else ""}>
            ${_("nsfw")}
          </input>
        </span>
        <button type="submit">
          ${_("apply")}
        </button>
      </form>
    </span>
  </div>
  %if thing.things:
      %for a in thing.things:
        ${a}
      %endfor
      <div class="nav-buttons">
        <span class="nextprev">${_("view more:")}&#32;
          ${plain_link(format_html("%s &rsaquo;", _("reload suggestions")), request.url, _sr_path=False)}
        </span>
      </div>
  %else:
    <div class="explore-header">
      <span class="explore-title">
        ${_("Our robots have no suggestions at the moment.")}
      </span>
    </div>
    <div class="nav-buttons">
      <span class="nextprev">
        ${plain_link(format_html("%s &rsaquo;", _("try again")), "/explore", _sr_path=False)}
      </span>
    </div>
  %endif
</div>
