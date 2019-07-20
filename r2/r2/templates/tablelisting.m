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
   cls = thing.lookups[0].__class__.__name__.lower()
 %>

<style type="text/css">
  .generic-table {
    font-size: small;
    color: black;
    margin-left: 5px;}
</style>

<div id="siteTable${_id}" class="sitetable ${cls}">
  <table class="generic-table">
  %for a in thing.things:
      ${a}
  %endfor
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
%if not thing.things:
  <p id="noresults" class="error">${_("there doesn't seem to be anything here")}</p>
%endif
