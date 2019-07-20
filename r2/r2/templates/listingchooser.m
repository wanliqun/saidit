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

<%namespace file="utils.m" import="classes"/>

<%def name="section_items(itemlist)">
  %for item in itemlist:
    <li ${classes(item['extra_class'], 'selected' if item['selected'] else None)}>
      <a href="${item['path']}">
        ${item['name']}
        %if 'description' in item:
          <br><span class="description">${item['description']}</span>
        %endif
      </a>
    </li>
  %endfor
</%def>

<div class="listing-chooser">
  <div class="grippy"></div>
  <div class="contents">
    <ul class="global">
      ${section_items(thing.sections['global'])}
    </ul>

    <h3>${_('multireddits')}</h3>
    %if thing.show_samples:
      <div class="intro">
        <p>${_('new! create sets of subreddits to view together.')}</p>
        <p>${_('for starters, try one of these:')}</p>
        <ul class="multis">
          ${section_items(thing.sections['sample'])}
        </ul>
        <p>${_('to hide these samples, create a multi of your own:')}</p>
      </div>
    %endif
    <ul class="multis">
      ${section_items(thing.sections['multi'])}
      <li class="create">
        <form>
          <input type="text" class="multi-name" placeholder="${_('name')}"></input>
          <div class="error"></div>
          <button>${_('create')}</button><div class="throbber"></div>
        </form>
      </li>
    </ul>

    <ul class="other">
      ${section_items(thing.sections['other'])}
    </ul>
  </div>
</div>
