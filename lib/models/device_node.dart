import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'device_node_property.dart';

class DeviceNode extends Equatable{
  final String id;
  final String name;
  final String type;
  final List<DeviceNodeProperty> properties;

  DeviceNode(this.id, this.name, this.type, this.properties);

    factory DeviceNode.fromJSon(dynamic json) =>
      DeviceNode(
        json['id'] as String,
        json['name'] as String,
        json['type'] as String,
       (json['properties'] as List).map((element) => DeviceNodeProperty.fromJSon(element)).toList()
      );
       

 

  @override
  List<Object> get props =>[id, name, type];

    }