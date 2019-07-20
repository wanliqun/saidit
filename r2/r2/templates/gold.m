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

<%namespace file="utils.m" import="error_field, radio_type, _md"/>
<%namespace file="utils/gold.m" import="gold_dropdown"/>

<div class="gold-wrap">
  <h1 class="gold-banner"><a href="/gold">${_('reddit gold')}</a></h1>

  <div class="fancy">
    <div class="fancy-inner">
      <div class="fancy-content gold-checkout">
        %if c.user_is_loggedin:
          ${self.gold_loggedin_content()}
        %else:
          ${self.gold_loggedout_content()}
        %endif
        <section class="gold-question">
          <h3 class="toggle">${_('What is reddit gold?')}</h3>
          <div class="details hidden">
            <div class="container">
              ${_('reddit gold is our premium membership.  It upgrades your account with access to extra features.')}
              &#32;
              <a href="/gold/about">${_('Learn more')}</a>.
            </div>
          </div>
        </section>
      </div>
    </div>
  </div>  
</div>

<%def name="gold_loggedout_content()">
  <header>
    <h2 class="loggedout-give-gold sidelines"><span>${_('Give Gold')}</span></h2>
    <div class="login-note">${_('Want to buy gold for yourself?')}&#32;<a href="/login" class="login-required">${_("You'll need to log in.")}</a></div>
  </header>

  <form class="loggedout-gold-form" name="loggedout-gold-form" action="/gold/payment" method="get">
    <input type="hidden" name="goldtype" value="code">
    <div id="form-options" class="container">
      <section>
        <label>
          <h3>${_('How many months of gold would you like to give?')}</h3>
          ${gold_dropdown("months", thing.months, "months")}
        </label>

        <label class="loggedout-email">
          <input type="email" name="email" class="inline" placeholder="enter your email address" value="${thing.email}">
          ## weird validation here because we're using GETs: this explicitly checks of email was passed in the URL so that
          ## the "no email" error doesn't show up on first page view.
          %if 'email' in request.GET and not thing.email:
            ${error_field("NO_EMAIL", "email", "span")}
          %endif
          ${error_field("BAD_EMAIL", "email", "span")}
          <p class="hint">${_("(We'll send a code to your email address you can then give to your recipient)")}</p>
        </label>
      </section>
    </div>

    <section id="payment-options">
      <div class="buttons">
        <button type="submit" class="btn gold-button">${_("buy reddit gold")}</button>
      </div>
    </section>
  </form>
</%def>

<%def name="gold_loggedin_content()">
  <%
  is_gift = thing.goldtype in ('code', 'gift')

  active_tab = None
  if thing.goldtype:
      if is_gift or thing.goldtype == 'onetime':
          active_tab = 'onetime'
      elif thing.goldtype == 'autorenew':
          active_tab = 'autorenew'
      else:
          active_tab = 'creddits'
  %>
  <form name="gold-form" class="gold-form" action="/gold/payment" method="get">
  <input type="hidden" name="edit" id="edit" value="true">
  <input type="hidden" name="goldtype" id="goldtype" value="${thing.goldtype}">

    <section class="tab-chooser">
      <h3>${_('What type of reddit gold would you like to purchase?')}</h3>
      <a href="#onetime" class="tab-toggle ${'active' if active_tab == 'onetime' else ''}">${_('one-time purchase')}</a>
      <a href="#autorenew" class="tab-toggle ${'active' if active_tab == 'autorenew' else ''}">${_('ongoing subscription')}</a>
      <a href="#creddits" class="tab-toggle ${'active' if active_tab == 'creddits' else ''}">${_('creddits')}</a>
    </section>

    <div id="form-options" class="container ${'hidden' if not active_tab else ''}">

      <section id="creddits" class="tab ${'active' if active_tab == 'creddits' else ''}">
        <h3>${_('How many creddits would you like to buy?')}</h3>
        ${gold_dropdown("num_creddits", thing.months, somethings="creddits")}

        <section class="creddits-explained">
          ${_('Stored as a balance on your account, creddits allow you to give gold without having to enter payment information. Each creddit you have can be converted into one month of reddit gold.')}
          &#32;<a href="/gilding#what-are-creddits">${_('Learn more about using creddits')}</a>.
        </section>
      </section>

      <section id="autorenew" class="tab ${'active' if active_tab == 'autorenew' else ''}">
        <h3>${_('What type of subscription would you like?')}</h3>
        <ul>
          <li>${radio_type("period", "monthly", _("monthly - %s") % g.gold_month_price, "", thing.period == "monthly")}</li>

          <li>${radio_type("period", "yearly", _("yearly - %s (%s/month)") % (g.gold_year_price, g.gold_year_price / 12),"", thing.period != "monthly")}</li>
        </ul>
      </section>

      <section id="onetime" class="tab ${'active' if active_tab == 'onetime' else ''}">
        <h3>${_('How many months?')}</h3>
        <%
          append_or_somethings = None
          if c.user_is_loggedin and c.user.gold_creddits > 0:
              append_or_somethings = "creddits"
        %>
        ${gold_dropdown("months", thing.months, append_or_somethings=append_or_somethings)}

        <section id="give-as-gift">
          <ul>
            <li>
            <label>
              <input type="radio" id="notgift" name="gift" value="0" ${"checked" if not is_gift else ""}>
              ${_('purchase this reddit gold for myself')}
            </label>
            </li>
            <li>
            <label>
              <input type="radio" id="gift" name="gift" value="1" ${"checked" if is_gift else ""}>
              ${_('give this reddit gold as a gift')}
            </label>
            </li>
          </ul>
          <div id="gifting-details" class="${'hidden' if not is_gift else ''}">
            <ul class="indent">
              <li>
                ${radio_type("gifttype", "code", _("receive gold as a gift code"), "", thing.goldtype == "code")}
              </li>
              <li>
                ${radio_type("gifttype", "gift", _("send gold to a user"), "", thing.goldtype == "gift")}

                <div class="gift-details ${'hidden' if not thing.goldtype == 'gift' else ''}" id="gifttype-details-gift">

                  <label>
                    ${_('who should receive this gold?')}
                    <input id="recipient" type="text" name="recipient" value="${thing.recipient.name if thing.recipient else ''}" placeholder="${_('enter a username')}" size="13" maxlength="20" class="inline">
                    ## weird validation here because we're using GETs: this explicitly checks if email was passed in the URL so that
                    ## the "no email" error doesn't show up on first page view.
                    %if 'recipient' in request.GET:
                      ${error_field("NO_USER", "recipient", "span")}
                      ${error_field("USER_DOESNT_EXIST", "recipient", "span")}
                    %endif
                  </label>

                  <ul class="indent">
                    <li>
                      <label>
                        <input type="checkbox" id="signed-false" name="signed" value="false" ${"checked" if not thing.signed else ""}>
                        ${_('make my gift anonymous')}
                      </label>
                    </li>
                    <li>
                      <label>
                        <input type="checkbox" id="message" name="message" value="message" ${"checked" if thing.giftmessage else ""}>
                        ${_('include a message')}
                      </label>
                    </li>
                    <li>
                      <textarea rows="5" cols="30" name="giftmessage" id="giftmessage" placeholder="${_('enter your message')}" class="giftmessage" maxlength="500">${thing.giftmessage}</textarea>
                    </li>
                  </ul>
                </div>
              </li>
            </ul>
          </div>
        </section>
      </section>
    </div>

    <section id="payment-options" class="${'hidden' if not active_tab else ''}">
      <div class="buttons">
        <button type="submit" class="btn gold-button">${_('continue')}</button>
      </div>
    </section>
  </form>

  <section id="redeem-a-code" class="${'hidden' if active_tab else ''}">
    <div class="sidelines"><span>${_('or')}</span></div>
    <form id="redeem-form" action="/api/claimgold" method="post" onsubmit="return post_form(this, 'claimgold');">
        <input type="text" name="code" value="" placeholder="${_('enter a gift code for redemption')}" maxlength="20">
        <div class="redeem-submit hidden">
          <div class="buttons">
            <button type="submit" class="btn gold-button">${_("redeem this code")}</button>
          </div>
          <div class="errors">
          ${error_field("NO_TEXT", "code", "span")}
          ${error_field("INVALID_CODE", "code", "span")}
          ${error_field("CLAIMED_CODE", "code", "span")}
          </div>
        </div>
    </form>
  </section>
</%def>
