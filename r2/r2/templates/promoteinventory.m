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
   from r2.lib import js
   import simplejson
%>

<%namespace name="pr" file="promotelinkbase.m" />
<%namespace file="utils.m" import="plain_link, error_field" />

${unsafe(js.use('sponsored'))}

<div class="sponsored-page">
  <div class="dashboard inventory-dashboard">
    <header>
      <h2>promoted link inventory for ${thing.display_name}</h2>
    </header>
    <div class="dashboard-content">
      <div class="editor">
        <div class="editor-group">
          ${pr.targeting_field(default_checked=thing.targeting_type)}
          ${pr.scheduling_field()}
        </div>
        <footer class="buttons">
          <button name="submit" onclick="r.sponsored.submit_inventory_form()">submit</button>
        </footer>
      </div>
    </div>
  </div>
  <table class="inventory-table">
      <caption>* inventory purchased as a part of a collection</caption>
      <thead>
          <tr>
          %for text in thing.header:
              <th>${text}</th>
          %endfor
          </tr>
      </thead>

      <tbody>
          %for row in thing.rows:
          <tr class="${'total' if row.is_total else ''}">
              <td class="title">
              %if not row.is_total:
                  <div class="author view-link">
                      ${plain_link(row.info['author'], row.info['edit_url'])}
                  </div>
              %else:
                  <div class="author">${row.info['title']}</div>
              %endif
              </td>
              %for column in row.columns:
                <td
                    %if column == '0':
                      class="no-inventory"
                    %endif
                    >${column}</td>
              %endfor
          %endfor
      </tbody>
  </table>
  %if thing.csv_url:
  <div class="promote-report-csv">
    ${plain_link(_("download as csv"), thing.csv_url)}
  </div>
  %endif
</div>

<script type="text/javascript">
    r.sponsored.set_form_render_fnc(r.sponsored.fill_inventory_form);
    r.sponsored.setup_geotargeting(${unsafe(simplejson.dumps(thing.regions))},
                                   ${unsafe(simplejson.dumps(thing.metros))});
    r.sponsored.setup_collections(${unsafe(simplejson.dumps(thing.collections))},
                                  ${unsafe(simplejson.dumps(thing.collection_input))});

    $(function() {
      init_startdate();
      init_enddate();
    });
</script>
