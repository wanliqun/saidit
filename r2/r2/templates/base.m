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

<!doctype html>
<%!
   from r2.lib.template_helpers import static
   from r2.models import Link, Comment, Subreddit
   from r2.lib import tracking
%>
<%namespace file="utils.m" import="js_setup, googleanalytics, googletagmanager, classes"/>
<html xmlns="http://www.w3.org/1999/xhtml" lang="${c.lang}"
      xml:lang="${c.lang}">
  <head>
    <title>${self.Title()}</title>
    <meta name="keywords" content="${self.keywords()}" />
    <meta name="description" content="${getattr(thing, 'short_description', None) or g.short_description}" />
    <meta name="referrer" content="${c.referrer_policy}">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link type="application/opensearchdescription+xml" rel="search" href="/static/opensearch.xml"/>
    <link rel="canonical" href="${thing.canonical_link}" />
    ${self.viewport()}
    ${self.robots()}
    ${self.pagemeta()}
    ${self.stylesheet()}
    ${self.javascript()}
    ${js_setup(getattr(thing, "extra_js_config", None))}

    ##things here may depend on globals, or included js, so we run them last
    <style type="text/css">
      ## <style>s are treated as RAWTEXT segments, so we can't `websafe()` their contents.
      ## According to the HTML spec's RAWTEXT parsing rules, this should work for escaping.
      ## http://www.w3.org/TR/html5/syntax.html#rawtext-less-than-sign-state
      ${unsafe(_("/* Custom css: use this block to insert special translation-dependent css in the page header */").replace("</", ""))}
    </style>

    ${self.head()}
  </head>

  <body ${classes(*thing.page_classes())}>
    ${googletagmanager()}
    ${self.bodyContent()}
    ${self.javascript_bottom()}
  </body>
</html>

<%def name="bodyContent()">
</%def>

<%def name="Title()">
${c.site.title}
</%def>

## CUSTOM
<%def name="keywords()">
${g.brander_site}, ${g.domain}, said it, antiextremes, anti extremes, antiextremes.com, vote, voting, comment, reddit, reddit replacement, new reddit, besides reddit, other than reddit, other reddit, saiditnet, anonymous, anonymous social media, comments, links, social media, posts, submit links
</%def>

<%def name="viewport()">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</%def>

<%def name="robots()">
   %if hasattr(thing, 'robots') and thing.robots:
     <meta name="robots" content="${thing.robots}" />
   %endif
</%def>

<%def name="head()">
${googleanalytics('web', thing.is_gold_page() if hasattr(thing, 'is_gold_page') else False)}
</%def>

<%def name="pagemeta()">
</%def>

<%def name="stylesheet()">
</%def>

<%def name="javascript()">
</%def>

<%def name="javascript_bottom()">
</%def>
