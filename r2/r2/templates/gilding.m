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

<%namespace file="utils.m" import="_md, _mdf"/>

<div class="gold-wrap">
  <h1 class="gold-banner"><a href="/gilding">${_('gilding')}</a></h1>

  <div class="fancy">
    <div class="fancy-inner">
        <div class="fancy-content">
            <div class="container">
                <dl class="gilding-faq">
                  <dt class="toggle toggled" id="what-is-gilding">${_('What is gilding?')}</dt>
                  <dd>
                    ${_md("Giving [reddit gold](/gold/about) is referred to as 'gilding'. You can either give reddit gold directly to a user or gild one of their posts or comments.")}
                  </dd>

                  <dt class="toggle toggled" id="how-do-i-gild">${_('How do I gild someone?')}</dt>
                  <dd>
                    ${_("You can click the 'give gold' link directly below a submission:")}

                    <div class="example">
                      <figure class="comment-gild">
                      </figure>
                    </div>

                    ${_("Or by giving them gold via their userpage:")}

                    <div class="example">
                      <figure class="userpage-gild">
                      </figure>
                    </div>
                  </dd>

                  <dt class="toggle toggled" id="how-much-does-it-cost">${_('How much does it cost?')}</dt>
                  <dd>
                    ${_mdf("A single gilding costs %(price)s. If you plan to do a lot you can get a discount if you purchase some [creddits](/creddits).", price=g.gold_month_price)}
                  </dd>

                  <dt class="toggle toggled" id="what-are-creddits">${_('What are creddits?')}</dt>
                  <dd>${_('Each creddit you have can be converted into one month of reddit gold. Stored as a balance on your account, creddits allow you to give gold without having to enter payment information.')}&#32;${_('Additionally, buying creddits in bulk lowers the cost of each gilding.')}
                  </dd>

                  <dt class="toggle toggled" id="using-creddits">${_('How do I use creddits?')}</dt>
                  <dd>${_('Your creddits are listed as a payment method on the checkout page.')}

                  <div class="example">
                      <figure class="using-creddits">
                      </figure>
                    </div>
                  </dd>

                </dl>
          </div>
            <div class="buttons">
                <a class="btn gold-button" href="/creddits">${_('purchase creddits')}</a>
            </div>
        </div>
    </div>
  </div>
</div>
