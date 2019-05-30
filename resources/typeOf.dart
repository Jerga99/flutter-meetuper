// Function takes input, and provides you output, in most cases...
void main() {
  PersonContainer.of<Doctor>();
}

class Doctor {}

class InheritedDoctor<T> {}

class PersonContainer<T> {
  T person;

  PersonContainer({this.person});

  static T of<T>() {
    Type type = typeOf<InheritedDoctor<T>>();
    print(type);
    return null;
  }
}

Type typeOf<T>() {
  return T;
}
