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

<%namespace file="utils.m" import="timestamp"/>

<%!
    from r2.lib.pages import WrappedUser
    from r2.lib.filters import SC_OFF, SC_ON
    from r2.lib.template_helpers import _wsf
%>

%if thing.diff:
    <p>
        ${unsafe(thing.diff)}
    </p>
%endif
<p>
    %if not thing.page_content_md:
        <em>${_("this page is empty")}</em>
    %else:
        ${unsafe(thing.page_content)}
    %endif
    ${unsafe(SC_OFF)}
    <textarea readonly class="source" rows="20" cols="20">${thing.page_content_md}</textarea>
    ${unsafe(SC_ON)}
</p>
<hr/>
<em>
%if thing.edit_date:
    %if thing.edit_by:
         ${_wsf("revision by %(user)s", user=WrappedUser(thing.edit_by))}
         &mdash;&nbsp;
    %endif
    ${timestamp(thing.edit_date, include_tense=True)}
%endif
<a href="#" class="toggle-source">${_("view source")}</a>
</em>
