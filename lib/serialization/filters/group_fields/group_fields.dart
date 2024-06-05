
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/try_convert.dart';

import '../radio_select/radio.dart';
part 'group_fields.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToBool()])
class GroupFields {
    String? fieldid;
    String? title;
    String? type;
    String? slug;
    bool? display_icon;
    bool? popular;
    dynamic display_icon_type;
    List<RadioSelect>? fields;

    GroupFields({
        this.fieldid,
        this.title,
        this.type,
        this.slug,
        this.display_icon,
        this.popular,
        this.display_icon_type,
        this.fields,
    });

    factory GroupFields.fromJson(Map json) => _$GroupFieldsFromJson(json);
    Map toJson() => _$GroupFieldsToJson(this);
}

