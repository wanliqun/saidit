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

<%namespace file="printablebuttons.m" import="toggle_button"/>

${self.subscribe_button(thing.sr, thing.data_attrs)}

<%def name="subscribe_button(sr, data_attrs, css_class='subscribe-button')">
    ${toggle_button(
        class_name="fancy-toggle-button " + css_class,
        title=_("subscribe"),
        alt_title=_("unsubscribe"),
        callback="subscribe('%s')" % sr._fullname,
        cancelback="unsubscribe('%s')" % sr._fullname,
        css_class="add",
        alt_css_class="remove",
        reverse=sr.subscriber,
        login_required=True,
        data_attrs=data_attrs,
    )}
</%def>
