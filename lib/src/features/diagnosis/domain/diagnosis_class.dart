// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Diagnosis {
  final String sadness;
  final String euphoric;
  final String exhausted;
  final String sleep_dissorder;
  final String mood_swing;
  final String suicidal_thoughts;
  final String anorxia;
  final String authority_respect;
  final String try_explanation;
  final String aggressive_response;
  final String ignore_and_move_on;
  final String nervous_break_down;
  final String admit_mistakes;
  final String overthinking;
  final String sexual_activity;
  final String concentration;
  final String optimisim;

  Diagnosis(
      this.sadness,
      this.euphoric,
      this.exhausted,
      this.sleep_dissorder,
      this.mood_swing,
      this.suicidal_thoughts,
      this.anorxia,
      this.authority_respect,
      this.try_explanation,
      this.aggressive_response,
      this.ignore_and_move_on,
      this.nervous_break_down,
      this.admit_mistakes,
      this.overthinking,
      this.sexual_activity,
      this.concentration,
      this.optimisim);

  double getProgress() {
    double progress = 0;
    toMap().forEach((key, value) {
      if (value != "") {
        progress += 5.8823529412;
      }
    });
    return progress;
  }

  Diagnosis copyWith({
    String? sadness,
    String? euphoric,
    String? exhausted,
    String? sleep_dissorder,
    String? mood_swing,
    String? suicidal_thoughts,
    String? anorxia,
    String? authority_respect,
    String? try_explanation,
    String? aggressive_response,
    String? ignore_and_move_on,
    String? nervous_break_down,
    String? admit_mistakes,
    String? overthinking,
    String? sexual_activity,
    String? concentration,
    String? optimisim,
  }) {
    return Diagnosis(
      sadness ?? this.sadness,
      euphoric ?? this.euphoric,
      exhausted ?? this.exhausted,
      sleep_dissorder ?? this.sleep_dissorder,
      mood_swing ?? this.mood_swing,
      suicidal_thoughts ?? this.suicidal_thoughts,
      anorxia ?? this.anorxia,
      authority_respect ?? this.authority_respect,
      try_explanation ?? this.try_explanation,
      aggressive_response ?? this.aggressive_response,
      ignore_and_move_on ?? this.ignore_and_move_on,
      nervous_break_down ?? this.nervous_break_down,
      admit_mistakes ?? this.admit_mistakes,
      overthinking ?? this.overthinking,
      sexual_activity ?? this.sexual_activity,
      concentration ?? this.concentration,
      optimisim ?? this.optimisim,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sadness': sadness,
      'euphoric': euphoric,
      'exhausted': exhausted,
      'sleep_dissorder': sleep_dissorder,
      'mood_swing': mood_swing,
      'suicidal_thoughts': suicidal_thoughts,
      'anorxia': anorxia,
      'authority_respect': authority_respect,
      'try_explanation': try_explanation,
      'aggressive_response': aggressive_response,
      'ignore_and_move_on': ignore_and_move_on,
      'nervous_break_down': nervous_break_down,
      'admit_mistakes': admit_mistakes,
      'overthinking': overthinking,
      'sexual_activity': sexual_activity,
      'concentration': concentration,
      'optimisim': optimisim,
    };
  }

  factory Diagnosis.fromMap(Map<String, dynamic> map) {
    return Diagnosis(
      map['sadness'] as String,
      map['euphoric'] as String,
      map['exhausted'] as String,
      map['sleep_dissorder'] as String,
      map['mood_swing'] as String,
      map['suicidal_thoughts'] as String,
      map['anorxia'] as String,
      map['authority_respect'] as String,
      map['try_explanation'] as String,
      map['aggressive_response'] as String,
      map['ignore_and_move_on'] as String,
      map['nervous_break_down'] as String,
      map['admit_mistakes'] as String,
      map['overthinking'] as String,
      map['sexual_activity'] as String,
      map['concentration'] as String,
      map['optimisim'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Diagnosis.fromJson(String source) =>
      Diagnosis.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Diagnosis(sadness: $sadness, euphoric: $euphoric, exhausted: $exhausted, sleep_dissorder: $sleep_dissorder, mood_swing: $mood_swing, suicidal_thoughts: $suicidal_thoughts, anorxia: $anorxia, authority_respect: $authority_respect, try_explanation: $try_explanation, aggressive_response: $aggressive_response, ignore_and_move_on: $ignore_and_move_on, nervous_break_down: $nervous_break_down, admit_mistakes: $admit_mistakes, overthinking: $overthinking, sexual_activity: $sexual_activity, concentration: $concentration, optimisim: $optimisim)';
  }

  @override
  bool operator ==(covariant Diagnosis other) {
    if (identical(this, other)) return true;

    return other.sadness == sadness &&
        other.euphoric == euphoric &&
        other.exhausted == exhausted &&
        other.sleep_dissorder == sleep_dissorder &&
        other.mood_swing == mood_swing &&
        other.suicidal_thoughts == suicidal_thoughts &&
        other.anorxia == anorxia &&
        other.authority_respect == authority_respect &&
        other.try_explanation == try_explanation &&
        other.aggressive_response == aggressive_response &&
        other.ignore_and_move_on == ignore_and_move_on &&
        other.nervous_break_down == nervous_break_down &&
        other.admit_mistakes == admit_mistakes &&
        other.overthinking == overthinking &&
        other.sexual_activity == sexual_activity &&
        other.concentration == concentration &&
        other.optimisim == optimisim;
  }

  @override
  int get hashCode {
    return sadness.hashCode ^
        euphoric.hashCode ^
        exhausted.hashCode ^
        sleep_dissorder.hashCode ^
        mood_swing.hashCode ^
        suicidal_thoughts.hashCode ^
        anorxia.hashCode ^
        authority_respect.hashCode ^
        try_explanation.hashCode ^
        aggressive_response.hashCode ^
        ignore_and_move_on.hashCode ^
        nervous_break_down.hashCode ^
        admit_mistakes.hashCode ^
        overthinking.hashCode ^
        sexual_activity.hashCode ^
        concentration.hashCode ^
        optimisim.hashCode;
  }
}
