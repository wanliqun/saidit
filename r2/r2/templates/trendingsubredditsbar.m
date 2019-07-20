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
    from r2.models import Link
%>

<div class="trending-subreddits">
  <div class="rank-spacer"></div>
  <div class="midcol-spacer"></div>
  <div class="trending-subreddits-content">
    <strong>${_('trending subreddits')}</strong>
    <ul>
    %for i, subreddit_name in enumerate(thing.subreddit_names):
      <li><a href="${Link.tracking_link('/%s/%s' % (g.brander_community_abbr, subreddit_name), context='trending_subreddits_bar', element_name='trending_sr_%s'%(i+1))}" target="_blank">/${g.brander_community_abbr}/${subreddit_name}</a></li>
    %endfor
    </ul>
    <a href="${thing.comment_url}" class="${thing.comment_label_cls}">${thing.comment_label}</a>
  </div>
</div>
