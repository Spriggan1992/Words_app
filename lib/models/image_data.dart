class ImgData {
  ImgData({
    this.tag,
    this.id,
    this.url,
    bool isSelected,
  }) : this.isSelected = isSelected ?? false;
  final String tag;
  final String id;
  final String url;
  final bool isSelected;

  ImgData copyWith({
    String tag,
    String id,
    String img,
    bool isSelected,
  }) {
    return ImgData(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      url: img ?? this.url,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ImgData &&
        o.tag == tag &&
        o.id == id &&
        o.url == url &&
        o.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return tag.hashCode ^ id.hashCode ^ url.hashCode ^ isSelected.hashCode;
  }
}
