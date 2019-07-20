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

<%namespace file="utils.m" import="md"/>

<div class="gold-wrap">
  <h1 class="gold-banner"><a href="/gold">${_('reddit gold')}</a></h1>
  <div class="fancy">
    <div class="fancy-inner">
      <div class="fancy-content">
        <div class="container">
          <p class="claim-message">${thing.claim_msg}
          %if thing.vendor_url:
            &#32;<a class="vendor-url" href="${thing.vendor_url}">${thing.vendor_url}</a>
          %endif
          </p>
            
          %if thing.lounge_md:
            <span class="lounge-msg">
              ${md(thing.lounge_md, wrap=True)}
            </span>
          %endif
        </div>
      </div>
    </div>
  </div>
</div>
