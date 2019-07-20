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
   from r2.lib.pages.admin_pages import admin_menu
%>
<%namespace file="less.m" import="less_stylesheet"/>
<%namespace file="utils.m" import="classes"/>

<%def name="adminbar_stylesheet()">
  %if c.show_admin_bar:
    ${less_stylesheet('mobile-adminbar.less')}
  %endif
</%def>

<%def name="indicator(name, label, on)">
  %if on:
    <span class="indicator ${name}"><span class="icon"></span>${label}</span>
  %endif
</%def>

%if c.show_admin_bar:
  <div id="admin-bar" ${classes('admin' if c.user_is_admin else None, 'debug' if g.debug else None)}>
    <div class="status-bar">
      <span class="caption">${_('status')}</span>
      ${indicator('admin', _('admin mode enabled'), c.user_is_admin)}
      %if c.user_is_admin:
        <span class="admin-off">${_('admin off')}</span>
      %endif
      ${indicator('debug', _('debug mode'), g.debug)}
      ${indicator('secure', _('secure'), c.secure)}
      ${indicator('dev-statics', _('development statics'), g.uncompressedJS)}
      ${indicator('prod-statics', _('production statics'), g.debug and not g.uncompressedJS)}
      ${indicator('disabled', _('ads disabled'), g.disable_ads)}
      ${indicator('disabled', _('captcha disabled'), g.disable_captcha)}
      ${indicator('disabled', _('ratelimit disabled'), g.disable_ratelimit)}
      <span class="controls">
        %if c.user_is_admin:
          ${admin_menu()}
        %endif
        <span class="timings-button"><span class="state">-</span>${_('timings')}</span>
        <span class="hide-button">${_('hide')}</span>
      </span>
    </div>
    <div class="timings-bar">
      <div class="expand-button">+</div>
      <div class="timelines">
        <div class="timeline timeline-browser"></div>
        <div class="timeline timeline-server"></div>
      </div>
    </div>
    <div class="show-button"></div>
  </div>
  <% from r2.lib import js %>
  ${unsafe(js.use('admin'))}
%endif
