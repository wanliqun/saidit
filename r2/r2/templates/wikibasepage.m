﻿## The contents of this file are subject to the Common Public Attribution
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
    from r2.config import feature
%>

<%namespace file="less.m" import="less_stylesheet"/>
<%inherit file="reddit.m"/>

<%def name="global_stylesheets()">
    ${less_stylesheet('mobile-wiki.less')}
    ${parent.global_stylesheets()}
</%def>

<%def name="actionsbar(actions)">
    %for action in actions:
        <a class="wikiaction wikiaction-${action[0]}
        %if action[0] == thing.action[0]:
            wikiaction-current
        %endif
        "
        %if action[2]:
            href="${thing.base_url}/${action[0]}/${thing.page}"
        %else:
            href="${thing.base_url}/${action[0]}"
        %endif
        data-type="subreddit"
        %if action[3]:
            data-event-action="pageview"
            data-event-detail="${action[3]}"
        %endif
        >${action[1]}</a>
    %endfor
</%def>

<%def name="content()">
    ${thing.infobar}
    <span>
        <h1 class="wikititle">
            %if thing.pagetitle:
                ${thing.pagetitle}
            %endif
            %if thing.page:
                <strong>${thing.page}</strong>
            %endif
        </h1>
        
        %if thing.pageactions:
            <span class="pageactions">
                ${actionsbar(thing.pageactions)}
            </span>
        %endif
    </span>
        
    <div class="wiki-page-content md-container">
        %if thing.description:
            <div class="description">
                <h2>
                    %for desc in thing.description:
                        ${desc}<br/>
                    %endfor
                </h2>
            </div>
        %endif
        ${thing.content()}
    </div>
</%def>
