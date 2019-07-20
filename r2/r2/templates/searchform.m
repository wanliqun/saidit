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
   from r2.config import feature
   from r2.models.subreddit import DefaultSR, AllSR, HomeSR, DynamicSR
   from r2.lib.template_helpers import add_sr, static
%>

<%def name="search_faq()">
  <div id="moresearchinfo">
  <p>use the following search parameters to narrow your results:</p>

  <dl>
      <dt>sub:<i>sub</i></dt>
      <dd>${_('find submissions in "sub"')}</dd>
      <dt>author:<i>username</i></dt>
      <dd>${_('find submissions by "username"')}</dd>
      <dt>site:<i>example.com</i></dt>
      <dd>${_('find submissions from "example.com"')}</dd>
      <dt>url:<i>text</i></dt>
      <dd>${_('search for "text" in url')}</dd>
      <dt>selftext:<i>text</i></dt>
      <dd>${_('search for "text" in self post contents')}</dd>
      <dt>self:yes (or self:no)</dt>
      <dd>${_('include (or exclude) self posts')}</dd>
  </dl>

  <p>e.g.&#32;<code>sub:pics site:imgur.com dog</code></p>

  </div>

  <p><a href="${g.https_endpoint}/wiki/search" id="search_showmore">${_('advanced search: by author, sub...')}</a></p>
</%def>

<form action="${add_sr(thing.search_path)}" id="search" role="search">
  <input type="text" 
         %if thing.prev_search:
           value="${thing.prev_search}" style=""
         %endif
         name="q" placeholder="${_('search')}" tabindex="20">

  %if feature.is_enabled('legacy_search') or c.user.pref_legacy_search or thing.simple:
    <input type="submit" value="" tabindex="22">
  %else:
    <button class="search-submit-button c-btn c-btn-primary" type='submit' aria-label="${_("Search")}">
      <span class="search-icon"></span>
    </button>
  %endif

  %if thing.subreddit_search:
    %if thing.over18_url and thing.prev_search:
      <p><a id="search_over18" href="${thing.over18_url}" rel="nofollow">${_('enable NSFW results')}</a></p>
    %endif
  %elif thing.simple:
  <div id="searchexpando" class="infobar">
    %if not isinstance(c.site, (DefaultSR, AllSR, HomeSR, DynamicSR)):
      <label><input type="checkbox" name="restrict_sr" tabindex="21">${_('limit my search to %(path)s') % dict(path=c.site.path.rstrip('/'))}</label>
    % endif
    ${search_faq()}
  </div>
  %else:
    %if not thing.site or isinstance(thing.site, (DefaultSR, AllSR, HomeSR, DynamicSR)):
      <input type="hidden" name="restrict_sr">
    %else:
      <label><input type="checkbox" ${'checked="checked"' if thing.restrict_sr else ''} name="restrict_sr" tabindex="21">
      ${_('limit my search to %(path)s') % dict(path=thing.site.path.rstrip('/'))}</label>
    %endif
    ${search_faq()}
  %endif

  %for k, v in thing.search_params.iteritems():
    <input type="hidden" name="${k}" value="${v}">
  %endfor
</form>
