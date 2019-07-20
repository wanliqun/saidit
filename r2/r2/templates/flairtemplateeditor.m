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

<%namespace name="utils" file="utils.m"/>

<div class="flairtemplate flairrow">
  <form action="/post/flairtemplate"
        ${'id=%s' % thing.id if thing.id else ''}
        method="post" class="medium-text flair-entry">
    %if thing.id:
      <input type="hidden" name="flair_template_id" value="${thing.id}" />
    %endif
    <input type="hidden" name="flair_type" value="${thing.flair_type}" />
    <span class="flaircell flairsample-${thing.position} tagline">
      %if thing.text or thing.css_class:
        ${unsafe(thing.sample.render())}
      %endif
    </span>
    <span class="flaircell narrow">
      <input type="checkbox" name="text_editable"
          ${'checked="checked"' if thing.text_editable else ''} />
    </span>
    <span class="flaircell">
      <input type="text" size="32" maxlength="64" name="text"
             value="${thing.text}" />
    </span>
    <span class="flaircell">
      <input type="text" size="32" maxlength="1000" name="css_class"
             value="${thing.css_class}" />
    </span>
    <button type="submit">save</button>
    %if thing.id:
      <button class="flairdeletebtn">delete</button>
    %endif
    <span class="status"></span>
    ${utils.error_field('BAD_CSS_NAME', 'css_class')}
    ${utils.error_field('TOO_MUCH_FLAIR_CSS', 'css_class')}
  </form>
</div>
