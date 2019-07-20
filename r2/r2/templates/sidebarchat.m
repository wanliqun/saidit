<div class="spacer">
% if thing.chat_client == 'kiwiirc':
    % if thing.user_is_loggedin:
        <iframe class="chat-iframe kiwiirc" src="https://kiwiirc.com/client/irc.foonetic.net/?nick=${thing.chat_user}#${thing.chat_channel}"></iframe>
    % else:
        <iframe class="chat-iframe kiwiirc" src="https://kiwiirc.com/client/irc.foonetic.net/?nick=${thing.chat_user}|?#${thing.chat_channel}"></iframe>
    % endif
% elif thing.chat_client == 'thelounge':
    % if thing.user_is_loggedin:
        ## NOTE - Omitting nofocus param
        <a target="_blank" class="chat-link" href="${thing.chat_client_url}/?tls=true&lockchannel&autologin&user=${thing.chat_client_user}&al-password=${thing.chat_client_password}&autoconnect&nick=${thing.chat_user}&username=${thing.chat_user}&realname=${thing.chat_user}&join=${thing.chat_channel}">chat in new tab</a>
        <iframe class="chat-iframe thelounge" src="${thing.chat_client_url}/?tls=true&nofocus&lockchannel&autologin&user=${thing.chat_client_user}&al-password=${thing.chat_client_password}&autoconnect&nick=${thing.chat_user}&username=${thing.chat_user}&realname=${thing.chat_user}&join=${thing.chat_channel}"></iframe>
    % else:
        ## NOTE - Omitting nofocus param
        <a target="_blank" class="chat-link" href="${thing.chat_client_url}/?tls=true&lockchannel&autologin&user=${thing.chat_client_user}&autoconnect&nick=${thing.chat_user}&username=${thing.chat_user}&realname=${thing.chat_user}&join=${thing.chat_channel}">chat in new tab</a>
        <iframe class="chat-iframe thelounge" src="${thing.chat_client_url}/?tls=true&nofocus&lockchannel&autologin&user=${thing.chat_client_user}&autoconnect&nick=${thing.chat_user}&username=${thing.chat_user}&realname=${thing.chat_user}&join=${thing.chat_channel}"></iframe>
    % endif
% endif
</div>

