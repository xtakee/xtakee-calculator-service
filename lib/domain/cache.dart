

const String PREF_SESSION_ID = "STAKE_ID";
const String PREF_AUTHORIZATION_ = "PREF_AUTHORIZATION_";
const String PREF_TAGS_ = "PREF_TAGS_";
const String PREF_STAKE = "PREF_STAKE";
const String PREF_RESTRICT_ROUND = "PREF_RESTRICT_ROUND";
const String PREF_RECYCLE = "PREF_RECYCLE";
const String PREF_DECAY = "PREF_DECAY";
const String PREF_CLEAR_LOSS = "PREF_CLEAR_LOSS";
const String PREF_STAKE_TYPE = "PREF_STAKE_TYPE";

abstract class Cache {
  Future<bool> set(String key, Object value);

  Future<bool> delete(String key);

  Future<bool> reset();

  int getInt(String key, int def);

  String getString(String key, String def);

  bool getBool(String key, bool def);

  double getDouble(String key, double def);
}
