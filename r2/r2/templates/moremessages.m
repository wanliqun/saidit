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

<%inherit file="message.m"/>

<%def name="thing_css_class(what)" buffered="True">
message ${parent.thing_css_class(what)} message-parent
</%def>

<%def name="commentBody()">
</%def>

<%def name="tagline(collapse=False)">
<span class="head">
  <a style="font-size: smaller; font-weight: bold" 
     id="more_${thing._fullname}" href="javascript:void(0)"
     onclick="return moremessages(this)"
     >
    ${_("[+] load the full conversation.")}
  </a>
</span>
</%def>

<%def name="arrows()">
</%def>

<%def name="buttons()">
</%def>

<%def name="midcol(cls = '')">
</%def>

