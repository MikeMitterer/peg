// This code was generated by a tool.
// Processing tool available at https://github.com/mezoni/peg

part of peg.example.arithmetic;

num _binop(num left, num right, String op) {
  switch(op) {
    case "+":
      return left + right;
    case "-":
      return left - right;
    case "*":
      return left * right;
    case "/":
      return left / right;
    default:
      throw "Unsupported operation $op";  
  }
}
class ArithmeticParser {
  static const int EOF = -1;
  static final List<String> _ascii = new List<String>.generate(128, (c) => new String.fromCharCode(c));
  static final List<bool> _lookahead = _unmap([0x800013, 0x3ff01]);
  // '\t', '\n', '\r', ' '
  static final List<bool> _mapping0 = _unmap([0x800013]);
  // "\r\n"
  static final List<int> _strings0 = <int>[13, 10];
  List _cache;
  int _cachePos;
  List<int> _cacheRule;
  List<int> _cacheState;
  int _ch;
  int _column;
  int _cursor;
  List<String> _expected;
  int _failurePos;
  int _inputLen;
  int _line;
  List<int> _runes;
  bool success;
  int _testing;
  String _token;
  int _tokenLevel;
  int _tokenStart;
  
  ArithmeticParser(String text) {
    if (text == null) {
      throw new ArgumentError('text: $text');
    }    
    _runes = _toRunes(text);
    _inputLen = _runes.length;
    if (_inputLen >= 0x3fffffe8 / 32) {
      throw new StateError('File size to big: $_inputLen');
    }  
    reset(0);    
  }
  
  int get column { 
    if (_column == -1) { 
      _calculatePos(_failurePos); 
    } 
    return _column;       
  } 
   
  int get line { 
    if (_line == -1) { 
      _calculatePos(_failurePos); 
    } 
    return _line;       
  } 
   
  dynamic _parse_Atom() {
    // NONTERMINAL
    // Atom <- NUMBER / OPEN Sentence CLOSE
    var $$;
    // NUMBER / OPEN Sentence CLOSE
    while (true) {
      // NUMBER
      $$ = null;
      success = _ch >= 48 && _ch <= 57 && _lookahead[_ch + -9];
      // Lookahead (NUMBER)
      if (success) $$ = _parse_NUMBER();    
      if (!success) {    
        if (_cursor > _testing) _failure(const ["NUMBER"]);
      }
      if (success) break;
      // OPEN Sentence CLOSE
      var ch0 = _ch, pos0 = _cursor;
      while (true) {  
        // OPEN
        $$ = null;
        success = _ch == 40; // '('
        // Lookahead (OPEN)
        if (success) $$ = _parse_OPEN();
        if (!success) {
          if (_cursor > _testing) _failure(const ["("]);  
          break;  
        }
        var seq = new List(3)..[0] = $$;
        // Sentence
        $$ = null;
        success = _ch >= 40 && _ch <= 57 && _lookahead[_ch + -9];
        // Lookahead (Sentence)
        if (success) $$ = _parse_Sentence();    
        if (!success) {    
          if (_cursor > _testing) _failure(const ["NUMBER", "("]);
          break;  
        }
        seq[1] = $$;
        // CLOSE
        $$ = null;
        success = _ch == 41; // ')'
        // Lookahead (CLOSE)
        if (success) $$ = _parse_CLOSE();
        if (!success) {
          if (_cursor > _testing) _failure(const [")"]);  
          break;  
        }
        seq[2] = $$;
        $$ = seq;
        if (success) {    
          // OPEN
          final $1 = seq[0];
          // Sentence
          final $2 = seq[1];
          // CLOSE
          final $3 = seq[2];
          $$ = $2;    
        }
        break;  
      }
      if (!success) {
        _ch = ch0;
        _cursor = pos0;
      }
      break;
    }
    if (!success && _cursor > _testing) {
      _failure(const ["NUMBER", "("]);
    }
    return $$;
  }
  
  dynamic _parse_CLOSE() {
    // TERMINAL
    // CLOSE <- ")" _SPACES
    var $$;
    if (_tokenLevel++ == 0) {  
      _token = ")";  
      _tokenStart = _cursor;  
    }  
    // ")" _SPACES
    var ch0 = _ch, pos0 = _cursor;
    while (true) {  
      // ")"
      $$ = _matchChar(41, ')');
      if (!success) break;
      var seq = new List(2)..[0] = $$;
      // _SPACES
      $$ = null;
      success = _ch >= 9 && _ch <= 32 && _lookahead[_ch + -9];
      // Lookahead (_SPACES is optional)
      if (success) $$ = _parse__SPACES();
      else success = true;
      seq[1] = $$;
      $$ = seq;
      break;  
    }
    if (!success) {
      _ch = ch0;
      _cursor = pos0;
    }
    if (!success && _cursor > _testing) {
      _failure(const [")"]);
    }
    if (--_tokenLevel == 0) {
      _token = null;
      _tokenStart = null;
    }
    return $$;
  }
  
  dynamic _parse_DIV() {
    // TERMINAL
    // DIV <- "/" _SPACES
    var $$;
    if (_tokenLevel++ == 0) {  
      _token = "/";  
      _tokenStart = _cursor;  
    }  
    // "/" _SPACES
    var ch0 = _ch, pos0 = _cursor;
    while (true) {  
      // "/"
      $$ = _matchChar(47, '/');
      if (!success) break;
      var seq = new List(2)..[0] = $$;
      // _SPACES
      $$ = null;
      success = _ch >= 9 && _ch <= 32 && _lookahead[_ch + -9];
      // Lookahead (_SPACES is optional)
      if (success) $$ = _parse__SPACES();
      else success = true;
      seq[1] = $$;
      $$ = seq;
      if (success) {    
        // "/"
        final $1 = seq[0];
        // _SPACES
        final $2 = seq[1];
        $$ = $1;    
      }
      break;  
    }
    if (!success) {
      _ch = ch0;
      _cursor = pos0;
    }
    if (!success && _cursor > _testing) {
      _failure(const ["/"]);
    }
    if (--_tokenLevel == 0) {
      _token = null;
      _tokenStart = null;
    }
    return $$;
  }
  
  dynamic _parse_EOF() {
    // TERMINAL
    // EOF <- !.
    var $$;
    if (_tokenLevel++ == 0) {  
      _token = "EOF";  
      _tokenStart = _cursor;  
    }  
    // !.
    var ch0 = _ch, pos0 = _cursor, testing0 = _testing; 
    _testing = _inputLen + 1;
    // .
    $$ = _matchAny();
    _ch = ch0;
    _cursor = pos0; 
    _testing = testing0;
    $$ = null;
    success = !success;
    if (!success && _cursor > _testing) {
      _failure(const [null, "EOF"]);
    }
    if (--_tokenLevel == 0) {
      _token = null;
      _tokenStart = null;
    }
    return $$;
  }
  
  dynamic _parse_MINUS() {
    // TERMINAL
    // MINUS <- "-" _SPACES
    var $$;
    if (_tokenLevel++ == 0) {  
      _token = "-";  
      _tokenStart = _cursor;  
    }  
    // "-" _SPACES
    var ch0 = _ch, pos0 = _cursor;
    while (true) {  
      // "-"
      $$ = _matchChar(45, '-');
      if (!success) break;
      var seq = new List(2)..[0] = $$;
      // _SPACES
      $$ = null;
      success = _ch >= 9 && _ch <= 32 && _lookahead[_ch + -9];
      // Lookahead (_SPACES is optional)
      if (success) $$ = _parse__SPACES();
      else success = true;
      seq[1] = $$;
      $$ = seq;
      if (success) {    
        // "-"
        final $1 = seq[0];
        // _SPACES
        final $2 = seq[1];
        $$ = $1;    
      }
      break;  
    }
    if (!success) {
      _ch = ch0;
      _cursor = pos0;
    }
    if (!success && _cursor > _testing) {
      _failure(const ["-"]);
    }
    if (--_tokenLevel == 0) {
      _token = null;
      _tokenStart = null;
    }
    return $$;
  }
  
  dynamic _parse_MUL() {
    // TERMINAL
    // MUL <- "*" _SPACES
    var $$;
    if (_tokenLevel++ == 0) {  
      _token = "*";  
      _tokenStart = _cursor;  
    }  
    // "*" _SPACES
    var ch0 = _ch, pos0 = _cursor;
    while (true) {  
      // "*"
      $$ = _matchChar(42, '*');
      if (!success) break;
      var seq = new List(2)..[0] = $$;
      // _SPACES
      $$ = null;
      success = _ch >= 9 && _ch <= 32 && _lookahead[_ch + -9];
      // Lookahead (_SPACES is optional)
      if (success) $$ = _parse__SPACES();
      else success = true;
      seq[1] = $$;
      $$ = seq;
      if (success) {    
        // "*"
        final $1 = seq[0];
        // _SPACES
        final $2 = seq[1];
        $$ = $1;    
      }
      break;  
    }
    if (!success) {
      _ch = ch0;
      _cursor = pos0;
    }
    if (!success && _cursor > _testing) {
      _failure(const ["*"]);
    }
    if (--_tokenLevel == 0) {
      _token = null;
      _tokenStart = null;
    }
    return $$;
  }
  
  dynamic _parse_NUMBER() {
    // TERMINAL
    // NUMBER <- [0-9]+ _SPACES
    var $$;
    if (_tokenLevel++ == 0) {  
      _token = "NUMBER";  
      _tokenStart = _cursor;  
    }  
    // [0-9]+ _SPACES
    var ch0 = _ch, pos0 = _cursor;
    while (true) {  
      // [0-9]+
      var testing0;
      for (var first = true, reps; ;) {  
        // [0-9]  
        $$ = _matchRange(48, 57);  
        if (success) {
         if (first) {      
            first = false;
            reps = [$$];
            testing0 = _testing;                  
          } else {
            reps.add($$);
          }
          _testing = _cursor;   
        } else {
          success = !first;
          if (success) {      
            _testing = testing0;
            $$ = reps;      
          } else $$ = null;
          break;
        }  
      }
      if (!success) break;
      var seq = new List(2)..[0] = $$;
      // _SPACES
      $$ = null;
      success = _ch >= 9 && _ch <= 32 && _lookahead[_ch + -9];
      // Lookahead (_SPACES is optional)
      if (success) $$ = _parse__SPACES();
      else success = true;
      seq[1] = $$;
      $$ = seq;
      if (success) {    
        // [0-9]+
        final $1 = seq[0];
        // _SPACES
        final $2 = seq[1];
        $$ = int.parse($1.join());    
      }
      break;  
    }
    if (!success) {
      _ch = ch0;
      _cursor = pos0;
    }
    if (!success && _cursor > _testing) {
      _failure(const ["NUMBER"]);
    }
    if (--_tokenLevel == 0) {
      _token = null;
      _tokenStart = null;
    }
    return $$;
  }
  
  dynamic _parse_OPEN() {
    // TERMINAL
    // OPEN <- "(" _SPACES
    var $$;
    if (_tokenLevel++ == 0) {  
      _token = "(";  
      _tokenStart = _cursor;  
    }  
    // "(" _SPACES
    var ch0 = _ch, pos0 = _cursor;
    while (true) {  
      // "("
      $$ = _matchChar(40, '(');
      if (!success) break;
      var seq = new List(2)..[0] = $$;
      // _SPACES
      $$ = null;
      success = _ch >= 9 && _ch <= 32 && _lookahead[_ch + -9];
      // Lookahead (_SPACES is optional)
      if (success) $$ = _parse__SPACES();
      else success = true;
      seq[1] = $$;
      $$ = seq;
      break;  
    }
    if (!success) {
      _ch = ch0;
      _cursor = pos0;
    }
    if (!success && _cursor > _testing) {
      _failure(const ["("]);
    }
    if (--_tokenLevel == 0) {
      _token = null;
      _tokenStart = null;
    }
    return $$;
  }
  
  dynamic _parse_PLUS() {
    // TERMINAL
    // PLUS <- "+" _SPACES
    var $$;
    if (_tokenLevel++ == 0) {  
      _token = "+";  
      _tokenStart = _cursor;  
    }  
    // "+" _SPACES
    var ch0 = _ch, pos0 = _cursor;
    while (true) {  
      // "+"
      $$ = _matchChar(43, '+');
      if (!success) break;
      var seq = new List(2)..[0] = $$;
      // _SPACES
      $$ = null;
      success = _ch >= 9 && _ch <= 32 && _lookahead[_ch + -9];
      // Lookahead (_SPACES is optional)
      if (success) $$ = _parse__SPACES();
      else success = true;
      seq[1] = $$;
      $$ = seq;
      if (success) {    
        // "+"
        final $1 = seq[0];
        // _SPACES
        final $2 = seq[1];
        $$ = $1;    
      }
      break;  
    }
    if (!success) {
      _ch = ch0;
      _cursor = pos0;
    }
    if (!success && _cursor > _testing) {
      _failure(const ["+"]);
    }
    if (--_tokenLevel == 0) {
      _token = null;
      _tokenStart = null;
    }
    return $$;
  }
  
  dynamic _parse_SPACES() {
    // TERMINAL
    // SPACES <- _SPACES
    var $$;
    if (_tokenLevel++ == 0) {  
      _token = "SPACES";  
      _tokenStart = _cursor;  
    }  
    // _SPACES
    $$ = null;
    success = _ch >= 9 && _ch <= 32 && _lookahead[_ch + -9];
    // Lookahead (_SPACES is optional)
    if (success) $$ = _parse__SPACES();
    else success = true;
    if (!success && _cursor > _testing) {
      _failure(const ["_SPACES", "SPACES"]);
    }
    if (--_tokenLevel == 0) {
      _token = null;
      _tokenStart = null;
    }
    return $$;
  }
  
  dynamic _parse_Sentence() {
    // NONTERMINAL
    // Sentence <- Term (PLUS / MINUS) Sentence / Term
    var pos = _cursor;    
    if(pos <= _cachePos) {
      $$ = _getFromCache(1);
    }
    if($$ != null) {
      return $$[0];       
    }
    var $$;
    // Term (PLUS / MINUS) Sentence / Term
    while (true) {
      // Term (PLUS / MINUS) Sentence
      var ch0 = _ch, pos0 = _cursor;
      while (true) {  
        // Term
        $$ = null;
        success = _ch >= 40 && _ch <= 57 && _lookahead[_ch + -9];
        // Lookahead (Term)
        if (success) $$ = _parse_Term();    
        if (!success) {    
          if (_cursor > _testing) _failure(const ["NUMBER", "("]);
          break;  
        }
        var seq = new List(3)..[0] = $$;
        // PLUS / MINUS
        while (true) {
          // PLUS
          $$ = null;
          success = _ch == 43; // '+'
          // Lookahead (PLUS)
          if (success) $$ = _parse_PLUS();
          if (!success) {
            if (_cursor > _testing) _failure(const ["+"]);  
          }
          if (success) break;
          // MINUS
          $$ = null;
          success = _ch == 45; // '-'
          // Lookahead (MINUS)
          if (success) $$ = _parse_MINUS();
          if (!success) {
            if (_cursor > _testing) _failure(const ["-"]);  
          }
          break;
        }
        if (!success && _cursor > _testing) {
          _failure(const ["+", "-"]);
        }
        if (!success) break;
        seq[1] = $$;
        // Sentence
        $$ = null;
        success = _ch >= 40 && _ch <= 57 && _lookahead[_ch + -9];
        // Lookahead (Sentence)
        if (success) $$ = _parse_Sentence();    
        if (!success) {    
          if (_cursor > _testing) _failure(const ["NUMBER", "("]);
          break;  
        }
        seq[2] = $$;
        $$ = seq;
        if (success) {    
          // Term
          final $1 = seq[0];
          // PLUS / MINUS
          final $2 = seq[1];
          // Sentence
          final $3 = seq[2];
          $$ = _binop($1, $3, $2);    
        }
        break;  
      }
      if (!success) {
        _ch = ch0;
        _cursor = pos0;
      }
      if (success) break;
      // Term
      $$ = null;
      success = _ch >= 40 && _ch <= 57 && _lookahead[_ch + -9];
      // Lookahead (Term)
      if (success) $$ = _parse_Term();    
      if (!success) {    
        if (_cursor > _testing) _failure(const ["NUMBER", "("]);
      }
      break;
    }
    if (!success && _cursor > _testing) {
      _failure(const ["NUMBER", "("]);
    }
    _addToCache($$, pos, 1);
    return $$;
  }
  
  dynamic _parse_Term() {
    // NONTERMINAL
    // Term <- Atom (MUL / DIV) Term / Atom
    var pos = _cursor;    
    if(pos <= _cachePos) {
      $$ = _getFromCache(2);
    }
    if($$ != null) {
      return $$[0];       
    }
    var $$;
    // Atom (MUL / DIV) Term / Atom
    while (true) {
      // Atom (MUL / DIV) Term
      var ch0 = _ch, pos0 = _cursor;
      while (true) {  
        // Atom
        $$ = null;
        success = _ch >= 40 && _ch <= 57 && _lookahead[_ch + -9];
        // Lookahead (Atom)
        if (success) $$ = _parse_Atom();    
        if (!success) {    
          if (_cursor > _testing) _failure(const ["NUMBER", "("]);
          break;  
        }
        var seq = new List(3)..[0] = $$;
        // MUL / DIV
        while (true) {
          // MUL
          $$ = null;
          success = _ch == 42; // '*'
          // Lookahead (MUL)
          if (success) $$ = _parse_MUL();
          if (!success) {
            if (_cursor > _testing) _failure(const ["*"]);  
          }
          if (success) break;
          // DIV
          $$ = null;
          success = _ch == 47; // '/'
          // Lookahead (DIV)
          if (success) $$ = _parse_DIV();
          if (!success) {
            if (_cursor > _testing) _failure(const ["/"]);  
          }
          break;
        }
        if (!success && _cursor > _testing) {
          _failure(const ["*", "/"]);
        }
        if (!success) break;
        seq[1] = $$;
        // Term
        $$ = null;
        success = _ch >= 40 && _ch <= 57 && _lookahead[_ch + -9];
        // Lookahead (Term)
        if (success) $$ = _parse_Term();    
        if (!success) {    
          if (_cursor > _testing) _failure(const ["NUMBER", "("]);
          break;  
        }
        seq[2] = $$;
        $$ = seq;
        if (success) {    
          // Atom
          final $1 = seq[0];
          // MUL / DIV
          final $2 = seq[1];
          // Term
          final $3 = seq[2];
          $$ = _binop($1, $3, $2);    
        }
        break;  
      }
      if (!success) {
        _ch = ch0;
        _cursor = pos0;
      }
      if (success) break;
      // Atom
      $$ = null;
      success = _ch >= 40 && _ch <= 57 && _lookahead[_ch + -9];
      // Lookahead (Atom)
      if (success) $$ = _parse_Atom();    
      if (!success) {    
        if (_cursor > _testing) _failure(const ["NUMBER", "("]);
      }
      break;
    }
    if (!success && _cursor > _testing) {
      _failure(const ["NUMBER", "("]);
    }
    _addToCache($$, pos, 2);
    return $$;
  }
  
  dynamic _parse_WS() {
    // TERMINAL
    // WS <- [\t-\n\r ] / "\r\n"
    var $$;
    if (_tokenLevel++ == 0) {  
      _token = "WS";  
      _tokenStart = _cursor;  
    }  
    // [\t-\n\r ] / "\r\n"
    while (true) {
      // [\t-\n\r ]
      $$ = _matchMapping(9, 32, _mapping0);
      if (success) break;
      // "\r\n"
      $$ = _matchString(_strings0, '\r\n');
      break;
    }
    if (!success && _cursor > _testing) {
      _failure(const ["WS"]);
    }
    if (--_tokenLevel == 0) {
      _token = null;
      _tokenStart = null;
    }
    return $$;
  }
  
  dynamic _parse__SPACES() {
    // TERMINAL
    // _SPACES <- WS*
    var pos = _cursor;    
    if(pos <= _cachePos) {
      $$ = _getFromCache(14);
    }
    if($$ != null) {
      return $$[0];       
    }
    var $$;
    if (_tokenLevel++ == 0) {    
      _token = "_SPACES";    
      _tokenStart = _cursor;    
    }    
    // WS*
    var testing0 = _testing; 
    for (var reps = []; ; ) {
      _testing = _cursor;
      // WS
      $$ = null;
      success = _ch >= 9 && _ch <= 32 && _lookahead[_ch + -9];
      // Lookahead (WS)
      if (success) $$ = _parse_WS();    
      if (!success) {    
        if (_cursor > _testing) _failure(const ["WS"]);
      }
      if (success) {  
        reps.add($$);
      } else {
        success = true;
        _testing = testing0;
        $$ = reps;
        break; 
      }
    }
    if (!success && _cursor > _testing) {
      _failure(const ["_SPACES"]);
    }
    _addToCache($$, pos, 14);
    if (--_tokenLevel == 0) {
      _token = null;
      _tokenStart = null;
    }
    return $$;
  }
  
  dynamic parse_Expr() {
    // NONTERMINAL
    // Expr <- SPACES? Sentence EOF
    var $$;
    // SPACES? Sentence EOF
    var ch0 = _ch, pos0 = _cursor;
    while (true) {  
      // SPACES?
      var testing0 = _testing;
      _testing = _cursor;
      // SPACES
      $$ = null;
      success = _ch >= 9 && _ch <= 32 && _lookahead[_ch + -9];
      // Lookahead (SPACES is optional)
      if (success) $$ = _parse_SPACES();
      else success = true;
      success = true; 
      _testing = testing0;
      if (!success) break;
      var seq = new List(3)..[0] = $$;
      // Sentence
      $$ = null;
      success = _ch >= 40 && _ch <= 57 && _lookahead[_ch + -9];
      // Lookahead (Sentence)
      if (success) $$ = _parse_Sentence();    
      if (!success) {    
        if (_cursor > _testing) _failure(const ["NUMBER", "("]);
        break;  
      }
      seq[1] = $$;
      // EOF
      $$ = _parse_EOF();
      if (!success) break;
      seq[2] = $$;
      $$ = seq;
      if (success) {    
        // SPACES?
        final $1 = seq[0];
        // Sentence
        final $2 = seq[1];
        // EOF
        final $3 = seq[2];
        $$ = $2;    
      }
      break;  
    }
    if (!success) {
      _ch = ch0;
      _cursor = pos0;
    }
    if (!success && _cursor > _testing) {
      _failure(const ["NUMBER", "("]);
    }
    return $$;
  }
  
  void _addToCache(dynamic result, int start, int id) {  
    var cached = _cache[start];
    if (cached == null) {
      _cacheRule[start] = id;
      _cache[start] = [result, _cursor, success];
    } else {    
      var slot = start >> 5;
      var r1 = (slot << 5) & 0x3fffffff;    
      var mask = 1 << (start - r1);    
      if ((_cacheState[slot] & mask) == 0) {
        _cacheState[slot] |= mask;   
        cached = [new List.filled(2, 0), new Map<int, List>()];
        _cache[start] = cached;                                      
      }
      slot = id >> 5;
      r1 = (slot << 5) & 0x3fffffff;    
      mask = 1 << (id - r1);    
      cached[0][slot] |= mask;
      cached[1][id] = [result, _cursor, success];      
    }
    if (_cachePos < start) {
      _cachePos = start;
    }    
  }
  
  void _calculatePos(int pos) {
    if (pos == null || pos < 0 || pos > _inputLen) {
      return;
    }
    _line = 1;
    _column = 1;
    for (var i = 0; i < _inputLen && i < pos; i++) {
      var c = _runes[i];
      if (c == 13) {
        _line++;
        _column = 1;
        if (i + 1 < _inputLen && _runes[i + 1] == 10) {
          i++;
        }
      } else if (c == 10) {
        _line++;
        _column = 1;
      } else {
        _column++;
      }
    }
  }
  
  Iterable _compact(Iterable iterable) {  
    if (iterable is List) {
      var hasNull = false;
      var length = iterable.length;
      for (var i = 0; i < length; i++) {
        if (iterable[i] == null) {
          hasNull = true;
          break;
        }
      }
      if (!hasNull) {
        return iterable;
      }
      var result = [];
      for (var i = 0; i < length; i++) {
        var element = iterable[i];
        if (element != null) {
          result.add(element);
        }
      }
      return result;
    }   
    var result = [];
    for (var element in iterable) {   
      if (element != null) {
        result.add(element);
      }
    }
    return result;  
  }
  
  void _failure([List<String> expected]) {  
    if (_failurePos > _cursor) {
      return;
    }
    if (_cursor > _failurePos) {    
      _expected = [];
     _failurePos = _cursor;
    }
    if (_token != null) {
      _expected.add(_token);
    } else if (expected == null) {
      _expected.add(null);
    } else {
      _expected.addAll(expected);
    }   
  }
  
  List _flatten(dynamic value) {
    if (value is List) {
      var result = [];
      var length = value.length;
      for (var i = 0; i < length; i++) {
        var element = value[i];
        if (element is Iterable) {
          result.addAll(_flatten(element));
        } else {
          result.add(element);
        }
      }
      return result;
    } else if (value is Iterable) {
      var result = [];
      for (var element in value) {
        if (element is! List) {
          result.add(element);
        } else {
          result.addAll(_flatten(element));
        }
      }
    }
    return [value];
  }
  
  dynamic _getFromCache(int id) {  
    var result = _cache[_cursor];
    if (result == null) {
      return null;
    }    
    var slot = _cursor >> 5;
    var r1 = (slot << 5) & 0x3fffffff;  
    var mask = 1 << (_cursor - r1);
    if ((_cacheState[slot] & mask) == 0) {
      if (_cacheRule[_cursor] == id) {      
        _cursor = result[1];
        success = result[2];      
        if (_cursor < _inputLen) {
          _ch = _runes[_cursor];
        } else {
          _ch = EOF;
        }      
        return result;
      } else {
        return null;
      }    
    }
    slot = id >> 5;
    r1 = (slot << 5) & 0x3fffffff;  
    mask = 1 << (id - r1);
    if ((result[0][slot] & mask) == 0) {
      return null;
    }
    var data = result[1][id];  
    _cursor = data[1];
    success = data[2];
    if (_cursor < _inputLen) {
      _ch = _runes[_cursor];
    } else {
      _ch = EOF;
    }   
    return data;  
  }
  
  String _matchAny() {
    success = _cursor < _inputLen;
    if (success) {
      String result;
      if (_ch < 128) {
        result = _ascii[_ch];  
      } else {
        result = new String.fromCharCode(_ch);
      }    
      if (++_cursor < _inputLen) {
        _ch = _runes[_cursor];
      } else {
        _ch = EOF;
      }    
      return result;
    }    
    return null;  
  }
  
  String _matchChar(int ch, String string) {
    success = _ch == ch;
    if (success) {
      var result = string;  
      if (++_cursor < _inputLen) {
        _ch = _runes[_cursor];
      } else {
        _ch = EOF;
      }    
      return result;
    }  
    return null;  
  }
  
  String _matchMapping(int start, int end, List<bool> mapping) {
    success = _ch >= start && _ch <= end;
    if (success) {    
      if(mapping[_ch - start]) {
        String result;
        if (_ch < 128) {
          result = _ascii[_ch];  
        } else {
          result = new String.fromCharCode(_ch);
        }     
        if (++_cursor < _inputLen) {
          _ch = _runes[_cursor];
        } else {
          _ch = EOF;
        }      
        return result;
      }
      success = false;
    }  
    return null;  
  }
  
  String _matchRange(int start, int end) {
    success = _ch >= start && _ch <= end;
    if (success) {
      String result;
      if (_ch < 128) {
        result = _ascii[_ch];  
      } else {
        result = new String.fromCharCode(_ch);
      }        
      if (++_cursor < _inputLen) {
        _ch = _runes[_cursor];
      } else {
        _ch = EOF;
      }  
      return result;
    }  
    return null;  
  }
  
  String _matchRanges(List<int> ranges) {
    var length = ranges.length;
    for (var i = 0; i < length; i += 2) {
      if (_ch <= ranges[i + 1]) {
        if (_ch >= ranges[i]) {
          String result;
          if (_ch < 128) {
            result = _ascii[_ch];  
          } else {
            result = new String.fromCharCode(_ch);
          }          
          if (++_cursor < _inputLen) {
            _ch = _runes[_cursor];
          } else {
             _ch = EOF;
          }
          success = true;    
          return result;
        }      
      } else break;  
    }
    success = false;  
    return null;  
  }
  
  String _matchString(List<int> runes, String string) {
    var length = runes.length;  
    success = true;  
    if (_cursor + length < _inputLen) {
      for (var i = 0; i < length; i++) {
        if (runes[i] != _runes[_cursor + i]) {
          success = false;
          break;
        }
      }
    } else {
      success = false;
    }  
    if (success) {
      _cursor += length;      
      if (_cursor < _inputLen) {
        _ch = _runes[_cursor];
      } else {
        _ch = EOF;
      }    
      return string;      
    }  
    return null; 
  }
  
  void _nextChar([int count = 1]) {  
    success = true;
    _cursor += count; 
    if (_cursor < _inputLen) {
      _ch = _runes[_cursor];
    } else {
      _ch = EOF;
    }    
  }
  
  bool _testChar(int c, int flag) {
    if (c < 0 || c > 127) {
      return false;
    }    
    int slot = (c & 0xff) >> 6;  
    int mask = 1 << c - ((slot << 6) & 0x3fffffff);  
    if ((flag & mask) != 0) {    
      return true;
    }
    return false;           
  }
  
  bool _testInput(int flag) {
    if (_cursor >= _inputLen) {
      return false;
    }
    var c = _runes[_cursor];
    if (c < 0 || c > 127) {
      return false;
    }    
    int slot = (c & 0xff) >> 6;  
    int mask = 1 << c - ((slot << 6) & 0x3fffffff);  
    if ((flag & mask) != 0) {    
      return true;
    }
    return false;           
  }
  
  int _toRune(String string) {
    if (string == null) {
      throw new ArgumentError("string: $string");
    }
  
    var length = string.length;
    if (length == 0) {
      throw new StateError("An empty string contains no elements.");
    }
  
    var start = string.codeUnitAt(0);
    if (length == 1) {
      return start;
    }
  
    if ((start & 0xFC00) == 0xD800) {
      var end = string.codeUnitAt(1);
      if ((end & 0xFC00) == 0xDC00) {
        return (0x10000 + ((start & 0x3FF) << 10) + (end & 0x3FF));
      }
    }
  
    return start;
  }
  
  List<int> _toRunes(String string) {
    if (string == null) {
      throw new ArgumentError("string: $string");
    }
  
    var length = string.length;
    if (length == 0) {
      return const <int>[];
    }
  
    var runes = <int>[];
    runes.length = length;
    var i = 0;
    var pos = 0;
    for ( ; i < length; pos++) {
      var start = string.codeUnitAt(i);
      i++;
      if ((start & 0xFC00) == 0xD800 && i < length) {
        var end = string.codeUnitAt(i);
        if ((end & 0xFC00) == 0xDC00) {
          runes[pos] = (0x10000 + ((start & 0x3FF) << 10) + (end & 0x3FF));
          i++;
        } else {
          runes[pos] = start;
        }
      } else {
        runes[pos] = start;
      }
    }
  
    runes.length = pos;
    return runes;
  }
  
  static List<bool> _unmap(List<int> mapping) {
    var length = mapping.length;
    var result = new List<bool>(length * 31);
    var offset = 0;
    for (var i = 0; i < length; i++) {
      var v = mapping[i];
      for (var j = 0; j < 31; j++) {
        result[offset++] = v & (1 << j) == 0 ? false : true;
      }
    }
    return result;
  }
  
  List<String> get expected {
    var set = new Set<String>();  
    set.addAll(_expected);
    if (set.contains(null)) {
      set.clear();
    }  
    var result = set.toList();
    result.sort(); 
    return result;        
  }
  
  void reset(int pos) {
    if (pos == null) {
      throw new ArgumentError('pos: $pos');
    }
    if (pos < 0 || pos > _inputLen) {
      throw new RangeError('pos');
    }      
    _cursor = pos;
    _cache = new List(_inputLen + 1);
    _cachePos = -1;
    _cacheRule = new List(_inputLen + 1);
    _cacheState = new List.filled(((_inputLen + 1) >> 5) + 1, 0);
    _ch = EOF;  
    _column = -1; 
    _expected = [];
    _failurePos = -1;    
    _line = -1;
    success = true;      
    _testing = -1;
    _token = null;
    _tokenLevel = 0;
    _tokenStart = null;
    if (_cursor < _inputLen) {
      _ch = _runes[_cursor];
    }    
  }
  
  String get unexpected {
    if (_failurePos < 0 || _failurePos >= _inputLen) {
      return '';    
    }
    return new String.fromCharCode(_runes[_failurePos]);  
  }
  
}

