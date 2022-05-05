List<int> kmpSearch(String pattern, String text)
{
  var LPS = List.filled(pattern.length,0);
  List<int> positions = <int>[];
  computeLPS(pattern, LPS);
  int i = 0;
  int j = 0;
  while (i < text.length) {
    if (pattern[j] == text[i]) {
      j++;
      i++;
    }
    if (j == pattern.length) {
      positions.add(i-j);
      j = LPS[j - 1];
    }
    else if (i < text.length && pattern[j] != text[i]) {
      if (j != 0)
        j = LPS[j - 1];
      else
        i = i + 1;
    }
  }
  return positions;
}

void computeLPS(String pattern, List<int> LPS)
{
  int len = 0;
  LPS[0] = 0;
  int i = 1;
  while (i < pattern.length) {
    if (pattern[i] == pattern[len]) {
      len++;
      LPS[i] = len;
      i++;
    }
    else
        {
      if (len != 0) {
        len = LPS[len - 1];
      }
      else
          {
        LPS[i] = 0;
        i++;
      }
    }
  }
}
