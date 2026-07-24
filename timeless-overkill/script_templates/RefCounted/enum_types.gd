# meta-name: Enum Type
# meta-description: Template for using enums as text instead of numbers (or both)
# meta-default: false
# meta-space-indent: 4
@abstract
class_name _CLASS_

enum Enum {
	
}

static func as_string(value: Enum) -> String:
	return Enum.find_key(value)

static func as_enum(value: String) -> Enum:
	return Enum.get(value, -1)
