// https://help.twitter.com/en/managing-your-account/twitter-username-rules
// https://stackoverflow.com/a/18373278
final twitterRegex = RegExp(r'^[a-zA-Z0-9_]{4,15}$');

// https://discord.com/developers/docs/resources/user#usernames-and-nicknames
// https://stackoverflow.com/a/71941303
final discordRegex =
    RegExp(r'^(?!(here|everyone))^(?!.*(discord|```)).[^\@\#\:]{2,32}#\d{4}$');

bool isHandleValid(String platform, String handle) {
  switch (platform) {
    case "Twitter":
      {
        return twitterRegex.hasMatch(handle);
      }
    case "Discord":
      {
        return discordRegex.hasMatch(handle);
      }
  }

  return handle.isNotEmpty;
}
