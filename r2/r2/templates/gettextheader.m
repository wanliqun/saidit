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

<%namespace file="translatedstring.m" import="text_input"/>

<% 
 highlight = lambda x: ("<span class='orangered' style='padding: 0px 1ex 0px 1ex'>" + x + "</span>")
 singular = unsafe(thing._singular(highlight))
 plural = unsafe(thing._plural(highlight))
 %>

%if c.user_is_admin:
%for indx in xrange(len(thing.headers)):
<% header = thing.headers[indx] %>
%if header[0]:
<tr id="tr_${thing.md5}" style="vertical-align:top">
  <td style="text-align: right; width: 25em; padding-right: 5px">
    ${header[0]}
  </td>
  <td></td>
  <td style="padding-bottom: 5px">
    ${text_input(header[1], True, index = indx, 
                 len=len(header[1]))}
  </td>
</tr>
%endif
%endfor
%endif
