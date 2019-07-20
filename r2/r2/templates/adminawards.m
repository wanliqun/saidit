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

<%namespace file="utils.m" import="error_field"/>

<%def name="awardbuttons(codename)">
  <ul class="flat-list buttons">
    <li><a href="#"
        onclick="$(this).parents('td').find('form').toggle(); return false;">
        edit</a></li>
    <li><a href="/admin/awards/${codename}/give">give</a></li>
    <li><a href="/admin/awards/${codename}/winners">winners</a></li>
  </ul>
</%def>

<%def name="awardtype_radio(val, label, award_fn, current)">
  <input id="awardtype_${award_fn}_${val}" class="nomargin"
         type="radio"  value="${val}" name="awardtype"
         ${"checked='checked'" if current == val else ''} />
  <label for="awardtype_${award_fn}_${val}">${label}</label>
  <br/>
</%def>

<%def name="awardedit(fullname, title='', awardtype='', codename='', imgurl='',
                      api_ok=False)">
 <form action="/post/editaward" method="post" class="pretty-form medium-text"
       style="display:none"
       onsubmit="return post_form(this, 'editaward');" id="awardedit-${fullname}">
  <input type="hidden" name="fullname" value="${fullname}" />

  <table class="lined-table borderless">
    <tr>
      <td>codename</td>
      <td>
        <input type="text" name="codename" value="${codename}" />
        ${error_field("NO_TEXT", "codename", "span")}
        ${error_field("INVALID_OPTION", "codename", "span")}
      </td>
    </tr>
    <tr>
      <td>title</td>
      <td>
        <input type="text" name="title" value="${title}" />
        ${error_field("NO_TEXT", "title", "span")}
      </td>
    </tr>
    <tr>
      <td>type</td>
      <td>
        ${awardtype_radio("regular", "regular", fullname, awardtype)}
        ${awardtype_radio("manual", "manual", fullname, awardtype)}
        ${awardtype_radio("invisible", "invisible", fullname, awardtype)}
        ${error_field("NO_TEXT", "awardtype", "span")}
      </td>
    </tr>
    <tr>
      <td>API ok?</td>
      <td>
        <input name="api_ok" id="award_${fullname}_api_ok"
          type="checkbox"
          %if api_ok:
            checked="checked"
          %endif
          />
        <label for="award_${fullname}_api_ok">
          allow adding/removing this award via API
        </label>
      </td>
    </tr>
    <tr>
      <td>img url</td>
      <td>
        <input type="text" name="imgurl" value="${imgurl}" />
        ${error_field("NO_TEXT", "imgurl", "span")}
        ${error_field("BAD_URL", "imgurl", "span")}
      </td>
    </tr>
  </table>
  <button class="btn" type="submit">save</button>
  <span class="status"></span>
 </form>
</%def>

<table class="lined-table">
 <tbody>
   <tr>
     <th>fn</th>
     <th>cn</th>
     <th>img</th>
     <th>title</th>
     <th>type</th>
     <th>buttons</th>
   </tr>
  %for award in thing.awards:
   <tr>
     <td>${award._fullname}</td>
     <td>${award.codename}</td>
     <td><img src="${award.imgurl % 40}"/></td>
     <td>${award.title}</td>
     <td>${award.awardtype}</td>
     <td class="entry">
       ${awardbuttons(award.codename)}
       ${awardedit(award._fullname, award.title, award.awardtype,
       award.codename, award.imgurl, award.api_ok)}
     </td>
   </tr>
  %endfor
 </tbody>
</table>

<button onclick="$('#awardedit-NEW').show()">new award</button>

${awardedit("NEW")}
