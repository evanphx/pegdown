require 'kpeg/compiled_parser'

class PegDown < KPeg::CompiledParser


  def extension(code)
    false
  end



  # root = Doc
  def _root
    _tmp = apply(:_Doc)
    set_failed_rule :_root unless _tmp
    return _tmp
  end

  # Doc = BOM? StartList:a (Block:b { "a = cons($$, a);"; a = [b, a] })* { 'parse_result = reverse(a); '; a.reverse }
  def _Doc

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_BOM)
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save3 = self.pos
        while true # sequence
          _tmp = apply(:_Block)
          b = @result
          unless _tmp
            self.pos = _save3
            break
          end
          @result = begin;  "a = cons($$, a);"; a = [b, a] ; end
          _tmp = true
          unless _tmp
            self.pos = _save3
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  'parse_result = reverse(a); '; a.reverse ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Doc unless _tmp
    return _tmp
  end

  # Block = BlankLine* (BlockQuote | Verbatim | Note | Reference | HorizontalRule | Heading | OrderedList | BulletList | HtmlBlock | StyleBlock | Para | Plain)
  def _Block

    _save = self.pos
    while true # sequence
      while true
        _tmp = apply(:_BlankLine)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end

      _save2 = self.pos
      while true # choice
        _tmp = apply(:_BlockQuote)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_Verbatim)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_Note)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_Reference)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_HorizontalRule)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_Heading)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_OrderedList)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_BulletList)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_HtmlBlock)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_StyleBlock)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_Para)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_Plain)
        break if _tmp
        self.pos = _save2
        break
      end # end choice

      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Block unless _tmp
    return _tmp
  end

  # Para = NonindentSpace Inlines:a BlankLine+ { raise "$$ = a; $$->key = PARA;" }
  def _Para

    _save = self.pos
    while true # sequence
      _tmp = apply(:_NonindentSpace)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Inlines)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_BlankLine)
      if _tmp
        while true
          _tmp = apply(:_BlankLine)
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise "$$ = a; $$->key = PARA;" ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Para unless _tmp
    return _tmp
  end

  # Plain = Inlines:a { a }
  def _Plain

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Inlines)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  a ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Plain unless _tmp
    return _tmp
  end

  # AtxInline = !Newline !(Sp? "#"* Sp Newline) Inline
  def _AtxInline

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_Newline)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos

      _save3 = self.pos
      while true # sequence
        _save4 = self.pos
        _tmp = apply(:_Sp)
        unless _tmp
          _tmp = true
          self.pos = _save4
        end
        unless _tmp
          self.pos = _save3
          break
        end
        while true
          _tmp = match_string("#")
          break unless _tmp
        end
        _tmp = true
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = apply(:_Sp)
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = apply(:_Newline)
        unless _tmp
          self.pos = _save3
        end
        break
      end # end sequence

      _tmp = _tmp ? nil : true
      self.pos = _save2
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Inline)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_AtxInline unless _tmp
    return _tmp
  end

  # AtxStart = < ("######" | "#####" | "####" | "###" | "##" | "#") > { raise " $$ = mk_element(H1 + (strlen(yytext) - 1)); " }
  def _AtxStart

    _save = self.pos
    while true # sequence
      _text_start = self.pos

      _save1 = self.pos
      while true # choice
        _tmp = match_string("######")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("#####")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("####")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("###")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("##")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("#")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_element(H1 + (strlen(yytext) - 1)); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_AtxStart unless _tmp
    return _tmp
  end

  # AtxHeading = AtxStart:s Sp? StartList:a (AtxInline { raise " a = cons($$, a); " })+ (Sp? "#"* Sp)? Newline { raise "$$ = mk_list(s->key, a);               free(s);" }
  def _AtxHeading

    _save = self.pos
    while true # sequence
      _tmp = apply(:_AtxStart)
      s = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_Sp)
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos

      _save3 = self.pos
      while true # sequence
        _tmp = apply(:_AtxInline)
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  raise " a = cons($$, a); " ; end
        _tmp = true
        unless _tmp
          self.pos = _save3
        end
        break
      end # end sequence

      if _tmp
        while true

          _save4 = self.pos
          while true # sequence
            _tmp = apply(:_AtxInline)
            unless _tmp
              self.pos = _save4
              break
            end
            @result = begin;  raise " a = cons($$, a); " ; end
            _tmp = true
            unless _tmp
              self.pos = _save4
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save2
      end
      unless _tmp
        self.pos = _save
        break
      end
      _save5 = self.pos

      _save6 = self.pos
      while true # sequence
        _save7 = self.pos
        _tmp = apply(:_Sp)
        unless _tmp
          _tmp = true
          self.pos = _save7
        end
        unless _tmp
          self.pos = _save6
          break
        end
        while true
          _tmp = match_string("#")
          break unless _tmp
        end
        _tmp = true
        unless _tmp
          self.pos = _save6
          break
        end
        _tmp = apply(:_Sp)
        unless _tmp
          self.pos = _save6
        end
        break
      end # end sequence

      unless _tmp
        _tmp = true
        self.pos = _save5
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Newline)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise "$$ = mk_list(s->key, a);
              free(s);" ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_AtxHeading unless _tmp
    return _tmp
  end

  # SetextHeading = (SetextHeading1 | SetextHeading2)
  def _SetextHeading

    _save = self.pos
    while true # choice
      _tmp = apply(:_SetextHeading1)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_SetextHeading2)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_SetextHeading unless _tmp
    return _tmp
  end

  # SetextBottom1 = "===" "="* Newline
  def _SetextBottom1

    _save = self.pos
    while true # sequence
      _tmp = match_string("===")
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = match_string("=")
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Newline)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_SetextBottom1 unless _tmp
    return _tmp
  end

  # SetextBottom2 = "---" "-"* Newline
  def _SetextBottom2

    _save = self.pos
    while true # sequence
      _tmp = match_string("---")
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = match_string("-")
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Newline)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_SetextBottom2 unless _tmp
    return _tmp
  end

  # SetextHeading1 = &(RawLine SetextBottom1) StartList:a (!Endline Inline { raise " a = cons($$, a); " })+ Sp? Newline SetextBottom1 { raise " $$ = mk_list(H1, a); " }
  def _SetextHeading1

    _save = self.pos
    while true # sequence
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _tmp = apply(:_RawLine)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_SetextBottom1)
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save3 = self.pos

      _save4 = self.pos
      while true # sequence
        _save5 = self.pos
        _tmp = apply(:_Endline)
        _tmp = _tmp ? nil : true
        self.pos = _save5
        unless _tmp
          self.pos = _save4
          break
        end
        _tmp = apply(:_Inline)
        unless _tmp
          self.pos = _save4
          break
        end
        @result = begin;  raise " a = cons($$, a); " ; end
        _tmp = true
        unless _tmp
          self.pos = _save4
        end
        break
      end # end sequence

      if _tmp
        while true

          _save6 = self.pos
          while true # sequence
            _save7 = self.pos
            _tmp = apply(:_Endline)
            _tmp = _tmp ? nil : true
            self.pos = _save7
            unless _tmp
              self.pos = _save6
              break
            end
            _tmp = apply(:_Inline)
            unless _tmp
              self.pos = _save6
              break
            end
            @result = begin;  raise " a = cons($$, a); " ; end
            _tmp = true
            unless _tmp
              self.pos = _save6
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save3
      end
      unless _tmp
        self.pos = _save
        break
      end
      _save8 = self.pos
      _tmp = apply(:_Sp)
      unless _tmp
        _tmp = true
        self.pos = _save8
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Newline)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_SetextBottom1)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_list(H1, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_SetextHeading1 unless _tmp
    return _tmp
  end

  # SetextHeading2 = &(RawLine SetextBottom2) StartList:a (!Endline Inline { raise " a = cons($$, a); " })+ Sp? Newline SetextBottom2 { raise " $$ = mk_list(H2, a); " }
  def _SetextHeading2

    _save = self.pos
    while true # sequence
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _tmp = apply(:_RawLine)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_SetextBottom2)
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save3 = self.pos

      _save4 = self.pos
      while true # sequence
        _save5 = self.pos
        _tmp = apply(:_Endline)
        _tmp = _tmp ? nil : true
        self.pos = _save5
        unless _tmp
          self.pos = _save4
          break
        end
        _tmp = apply(:_Inline)
        unless _tmp
          self.pos = _save4
          break
        end
        @result = begin;  raise " a = cons($$, a); " ; end
        _tmp = true
        unless _tmp
          self.pos = _save4
        end
        break
      end # end sequence

      if _tmp
        while true

          _save6 = self.pos
          while true # sequence
            _save7 = self.pos
            _tmp = apply(:_Endline)
            _tmp = _tmp ? nil : true
            self.pos = _save7
            unless _tmp
              self.pos = _save6
              break
            end
            _tmp = apply(:_Inline)
            unless _tmp
              self.pos = _save6
              break
            end
            @result = begin;  raise " a = cons($$, a); " ; end
            _tmp = true
            unless _tmp
              self.pos = _save6
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save3
      end
      unless _tmp
        self.pos = _save
        break
      end
      _save8 = self.pos
      _tmp = apply(:_Sp)
      unless _tmp
        _tmp = true
        self.pos = _save8
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Newline)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_SetextBottom2)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_list(H2, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_SetextHeading2 unless _tmp
    return _tmp
  end

  # Heading = (SetextHeading | AtxHeading)
  def _Heading

    _save = self.pos
    while true # choice
      _tmp = apply(:_SetextHeading)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_AtxHeading)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_Heading unless _tmp
    return _tmp
  end

  # BlockQuote = BlockQuoteRaw:a {  raise "$$ = mk_element(BLOCKQUOTE);                 $$->children = a;"              }
  def _BlockQuote

    _save = self.pos
    while true # sequence
      _tmp = apply(:_BlockQuoteRaw)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;   raise "$$ = mk_element(BLOCKQUOTE);
                $$->children = a;"
             ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_BlockQuote unless _tmp
    return _tmp
  end

  # BlockQuoteRaw = StartList:a (">" " "? Line { raise " a = cons($$, a); " } (!">" !BlankLine Line { raise " a = cons($$, a); " })* (BlankLine { raise ' a = cons(mk_str("\n"), a); ' })*)+ {   raise '$$ = mk_str_from_list(a, true);                      $$->key = RAW;'                  }
  def _BlockQuoteRaw

    _save = self.pos
    while true # sequence
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _tmp = match_string(">")
        unless _tmp
          self.pos = _save2
          break
        end
        _save3 = self.pos
        _tmp = match_string(" ")
        unless _tmp
          _tmp = true
          self.pos = _save3
        end
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_Line)
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  raise " a = cons($$, a); " ; end
        _tmp = true
        unless _tmp
          self.pos = _save2
          break
        end
        while true

          _save5 = self.pos
          while true # sequence
            _save6 = self.pos
            _tmp = match_string(">")
            _tmp = _tmp ? nil : true
            self.pos = _save6
            unless _tmp
              self.pos = _save5
              break
            end
            _save7 = self.pos
            _tmp = apply(:_BlankLine)
            _tmp = _tmp ? nil : true
            self.pos = _save7
            unless _tmp
              self.pos = _save5
              break
            end
            _tmp = apply(:_Line)
            unless _tmp
              self.pos = _save5
              break
            end
            @result = begin;  raise " a = cons($$, a); " ; end
            _tmp = true
            unless _tmp
              self.pos = _save5
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
        unless _tmp
          self.pos = _save2
          break
        end
        while true

          _save9 = self.pos
          while true # sequence
            _tmp = apply(:_BlankLine)
            unless _tmp
              self.pos = _save9
              break
            end
            @result = begin;  raise ' a = cons(mk_str("\n"), a); ' ; end
            _tmp = true
            unless _tmp
              self.pos = _save9
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      if _tmp
        while true

          _save10 = self.pos
          while true # sequence
            _tmp = match_string(">")
            unless _tmp
              self.pos = _save10
              break
            end
            _save11 = self.pos
            _tmp = match_string(" ")
            unless _tmp
              _tmp = true
              self.pos = _save11
            end
            unless _tmp
              self.pos = _save10
              break
            end
            _tmp = apply(:_Line)
            unless _tmp
              self.pos = _save10
              break
            end
            @result = begin;  raise " a = cons($$, a); " ; end
            _tmp = true
            unless _tmp
              self.pos = _save10
              break
            end
            while true

              _save13 = self.pos
              while true # sequence
                _save14 = self.pos
                _tmp = match_string(">")
                _tmp = _tmp ? nil : true
                self.pos = _save14
                unless _tmp
                  self.pos = _save13
                  break
                end
                _save15 = self.pos
                _tmp = apply(:_BlankLine)
                _tmp = _tmp ? nil : true
                self.pos = _save15
                unless _tmp
                  self.pos = _save13
                  break
                end
                _tmp = apply(:_Line)
                unless _tmp
                  self.pos = _save13
                  break
                end
                @result = begin;  raise " a = cons($$, a); " ; end
                _tmp = true
                unless _tmp
                  self.pos = _save13
                end
                break
              end # end sequence

              break unless _tmp
            end
            _tmp = true
            unless _tmp
              self.pos = _save10
              break
            end
            while true

              _save17 = self.pos
              while true # sequence
                _tmp = apply(:_BlankLine)
                unless _tmp
                  self.pos = _save17
                  break
                end
                @result = begin;  raise ' a = cons(mk_str("\n"), a); ' ; end
                _tmp = true
                unless _tmp
                  self.pos = _save17
                end
                break
              end # end sequence

              break unless _tmp
            end
            _tmp = true
            unless _tmp
              self.pos = _save10
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;    raise '$$ = mk_str_from_list(a, true);
                     $$->key = RAW;'
                 ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_BlockQuoteRaw unless _tmp
    return _tmp
  end

  # NonblankIndentedLine = !BlankLine IndentedLine
  def _NonblankIndentedLine

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_BlankLine)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_IndentedLine)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_NonblankIndentedLine unless _tmp
    return _tmp
  end

  # VerbatimChunk = StartList:a (BlankLine { raise ' a = cons(mk_str("\n"), a); ' })* (NonblankIndentedLine { raise " a = cons($$, a); " })+ { raise " $$ = mk_str_from_list(a, false); " }
  def _VerbatimChunk

    _save = self.pos
    while true # sequence
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # sequence
          _tmp = apply(:_BlankLine)
          unless _tmp
            self.pos = _save2
            break
          end
          @result = begin;  raise ' a = cons(mk_str("\n"), a); ' ; end
          _tmp = true
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _save3 = self.pos

      _save4 = self.pos
      while true # sequence
        _tmp = apply(:_NonblankIndentedLine)
        unless _tmp
          self.pos = _save4
          break
        end
        @result = begin;  raise " a = cons($$, a); " ; end
        _tmp = true
        unless _tmp
          self.pos = _save4
        end
        break
      end # end sequence

      if _tmp
        while true

          _save5 = self.pos
          while true # sequence
            _tmp = apply(:_NonblankIndentedLine)
            unless _tmp
              self.pos = _save5
              break
            end
            @result = begin;  raise " a = cons($$, a); " ; end
            _tmp = true
            unless _tmp
              self.pos = _save5
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save3
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_str_from_list(a, false); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_VerbatimChunk unless _tmp
    return _tmp
  end

  # Verbatim = StartList:a (VerbatimChunk { raise " a = cons($$, a); " })+ { raise '$$ = mk_str_from_list(a, false);                  $$->key = VERBATIM;' }
  def _Verbatim

    _save = self.pos
    while true # sequence
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _tmp = apply(:_VerbatimChunk)
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  raise " a = cons($$, a); " ; end
        _tmp = true
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      if _tmp
        while true

          _save3 = self.pos
          while true # sequence
            _tmp = apply(:_VerbatimChunk)
            unless _tmp
              self.pos = _save3
              break
            end
            @result = begin;  raise " a = cons($$, a); " ; end
            _tmp = true
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise '$$ = mk_str_from_list(a, false);
                 $$->key = VERBATIM;' ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Verbatim unless _tmp
    return _tmp
  end

  # HorizontalRule = NonindentSpace ("*" Sp "*" Sp "*" (Sp "*")* | "-" Sp "-" Sp "-" (Sp "-")* | "_" Sp "_" Sp "_" (Sp "_")*) Sp Newline BlankLine+ { raise " $$ = mk_element(HRULE); " }
  def _HorizontalRule

    _save = self.pos
    while true # sequence
      _tmp = apply(:_NonindentSpace)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice

        _save2 = self.pos
        while true # sequence
          _tmp = match_string("*")
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = match_string("*")
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = match_string("*")
          unless _tmp
            self.pos = _save2
            break
          end
          while true

            _save4 = self.pos
            while true # sequence
              _tmp = apply(:_Sp)
              unless _tmp
                self.pos = _save4
                break
              end
              _tmp = match_string("*")
              unless _tmp
                self.pos = _save4
              end
              break
            end # end sequence

            break unless _tmp
          end
          _tmp = true
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save1

        _save5 = self.pos
        while true # sequence
          _tmp = match_string("-")
          unless _tmp
            self.pos = _save5
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save5
            break
          end
          _tmp = match_string("-")
          unless _tmp
            self.pos = _save5
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save5
            break
          end
          _tmp = match_string("-")
          unless _tmp
            self.pos = _save5
            break
          end
          while true

            _save7 = self.pos
            while true # sequence
              _tmp = apply(:_Sp)
              unless _tmp
                self.pos = _save7
                break
              end
              _tmp = match_string("-")
              unless _tmp
                self.pos = _save7
              end
              break
            end # end sequence

            break unless _tmp
          end
          _tmp = true
          unless _tmp
            self.pos = _save5
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save1

        _save8 = self.pos
        while true # sequence
          _tmp = match_string("_")
          unless _tmp
            self.pos = _save8
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save8
            break
          end
          _tmp = match_string("_")
          unless _tmp
            self.pos = _save8
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save8
            break
          end
          _tmp = match_string("_")
          unless _tmp
            self.pos = _save8
            break
          end
          while true

            _save10 = self.pos
            while true # sequence
              _tmp = apply(:_Sp)
              unless _tmp
                self.pos = _save10
                break
              end
              _tmp = match_string("_")
              unless _tmp
                self.pos = _save10
              end
              break
            end # end sequence

            break unless _tmp
          end
          _tmp = true
          unless _tmp
            self.pos = _save8
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Newline)
      unless _tmp
        self.pos = _save
        break
      end
      _save11 = self.pos
      _tmp = apply(:_BlankLine)
      if _tmp
        while true
          _tmp = apply(:_BlankLine)
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save11
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_element(HRULE); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HorizontalRule unless _tmp
    return _tmp
  end

  # Bullet = !HorizontalRule NonindentSpace ("+" | "*" | "-") Spacechar+
  def _Bullet

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_HorizontalRule)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_NonindentSpace)
      unless _tmp
        self.pos = _save
        break
      end

      _save2 = self.pos
      while true # choice
        _tmp = match_string("+")
        break if _tmp
        self.pos = _save2
        _tmp = match_string("*")
        break if _tmp
        self.pos = _save2
        _tmp = match_string("-")
        break if _tmp
        self.pos = _save2
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _save3 = self.pos
      _tmp = apply(:_Spacechar)
      if _tmp
        while true
          _tmp = apply(:_Spacechar)
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save3
      end
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Bullet unless _tmp
    return _tmp
  end

  # BulletList = &Bullet (ListTight | ListLoose) { raise " $$->key = BULLETLIST; " }
  def _BulletList

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_Bullet)
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end

      _save2 = self.pos
      while true # choice
        _tmp = apply(:_ListTight)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_ListLoose)
        break if _tmp
        self.pos = _save2
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$->key = BULLETLIST; " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_BulletList unless _tmp
    return _tmp
  end

  # ListTight = StartList:a (ListItemTight { raise " a = cons($$, a); " })+ BlankLine* !(Bullet | Enumerator) { raise " $$ = mk_list(LIST, a); " }
  def _ListTight

    _save = self.pos
    while true # sequence
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _tmp = apply(:_ListItemTight)
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  raise " a = cons($$, a); " ; end
        _tmp = true
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      if _tmp
        while true

          _save3 = self.pos
          while true # sequence
            _tmp = apply(:_ListItemTight)
            unless _tmp
              self.pos = _save3
              break
            end
            @result = begin;  raise " a = cons($$, a); " ; end
            _tmp = true
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_BlankLine)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _save5 = self.pos

      _save6 = self.pos
      while true # choice
        _tmp = apply(:_Bullet)
        break if _tmp
        self.pos = _save6
        _tmp = apply(:_Enumerator)
        break if _tmp
        self.pos = _save6
        break
      end # end choice

      _tmp = _tmp ? nil : true
      self.pos = _save5
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_list(LIST, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_ListTight unless _tmp
    return _tmp
  end

  # ListLoose = StartList:a (b:listItem BlankLine* {   raise 'element *li;                   li = b->children;                   li->contents.str = realloc(li->contents.str, strlen(li->contents.str) + 3);                   strcat(li->contents.str, "\n\n");  /* In loose list, \n\n added to end of each element */                   a = cons(b, a);'               })+ { raise " $$ = mk_list(LIST, a); " }
  def _ListLoose

    _save = self.pos
    while true # sequence
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _tmp = apply(:_b)
        listItem = @result
        unless _tmp
          self.pos = _save2
          break
        end
        while true
          _tmp = apply(:_BlankLine)
          break unless _tmp
        end
        _tmp = true
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;    raise 'element *li;
                  li = b->children;
                  li->contents.str = realloc(li->contents.str, strlen(li->contents.str) + 3);
                  strcat(li->contents.str, "\n\n");  /* In loose list, \n\n added to end of each element */
                  a = cons(b, a);'
              ; end
        _tmp = true
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      if _tmp
        while true

          _save4 = self.pos
          while true # sequence
            _tmp = apply(:_b)
            listItem = @result
            unless _tmp
              self.pos = _save4
              break
            end
            while true
              _tmp = apply(:_BlankLine)
              break unless _tmp
            end
            _tmp = true
            unless _tmp
              self.pos = _save4
              break
            end
            @result = begin;    raise 'element *li;
                  li = b->children;
                  li->contents.str = realloc(li->contents.str, strlen(li->contents.str) + 3);
                  strcat(li->contents.str, "\n\n");  /* In loose list, \n\n added to end of each element */
                  a = cons(b, a);'
              ; end
            _tmp = true
            unless _tmp
              self.pos = _save4
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_list(LIST, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_ListLoose unless _tmp
    return _tmp
  end

  # ListItem = (Bullet | Enumerator) StartList:a ListBlock { raise " a = cons($$, a); " } (ListContinuationBlock { raise " a = cons($$, a); " })* {  raise 'element *raw;                raw = mk_str_from_list(a, false);                raw->key = RAW;                $$ = mk_element(LISTITEM);                $$->children = raw;'             }
  def _ListItem

    _save = self.pos
    while true # sequence

      _save1 = self.pos
      while true # choice
        _tmp = apply(:_Bullet)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_Enumerator)
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_ListBlock)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " a = cons($$, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save3 = self.pos
        while true # sequence
          _tmp = apply(:_ListContinuationBlock)
          unless _tmp
            self.pos = _save3
            break
          end
          @result = begin;  raise " a = cons($$, a); " ; end
          _tmp = true
          unless _tmp
            self.pos = _save3
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;   raise 'element *raw;
               raw = mk_str_from_list(a, false);
               raw->key = RAW;
               $$ = mk_element(LISTITEM);
               $$->children = raw;'
            ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_ListItem unless _tmp
    return _tmp
  end

  # ListItemTight = (Bullet | Enumerator) StartList:a ListBlock { raise " a = cons($$, a); " } (!BlankLine ListContinuationBlock { raise " a = cons($$, a); " })* !ListContinuationBlock {  raise 'element *raw;                raw = mk_str_from_list(a, false);                raw->key = RAW;                $$ = mk_element(LISTITEM);                $$->children = raw;'             }
  def _ListItemTight

    _save = self.pos
    while true # sequence

      _save1 = self.pos
      while true # choice
        _tmp = apply(:_Bullet)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_Enumerator)
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_ListBlock)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " a = cons($$, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save3 = self.pos
        while true # sequence
          _save4 = self.pos
          _tmp = apply(:_BlankLine)
          _tmp = _tmp ? nil : true
          self.pos = _save4
          unless _tmp
            self.pos = _save3
            break
          end
          _tmp = apply(:_ListContinuationBlock)
          unless _tmp
            self.pos = _save3
            break
          end
          @result = begin;  raise " a = cons($$, a); " ; end
          _tmp = true
          unless _tmp
            self.pos = _save3
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _save5 = self.pos
      _tmp = apply(:_ListContinuationBlock)
      _tmp = _tmp ? nil : true
      self.pos = _save5
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;   raise 'element *raw;
               raw = mk_str_from_list(a, false);
               raw->key = RAW;
               $$ = mk_element(LISTITEM);
               $$->children = raw;'
            ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_ListItemTight unless _tmp
    return _tmp
  end

  # ListBlock = StartList:a !BlankLine Line { raise " a = cons($$, a); " } (ListBlockLine { raise " a = cons($$, a); " })* { raise " $$ = mk_str_from_list(a, false); " }
  def _ListBlock

    _save = self.pos
    while true # sequence
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_BlankLine)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Line)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " a = cons($$, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save3 = self.pos
        while true # sequence
          _tmp = apply(:_ListBlockLine)
          unless _tmp
            self.pos = _save3
            break
          end
          @result = begin;  raise " a = cons($$, a); " ; end
          _tmp = true
          unless _tmp
            self.pos = _save3
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_str_from_list(a, false); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_ListBlock unless _tmp
    return _tmp
  end

  # ListContinuationBlock = StartList:a < BlankLine* > {   raise 'if (strlen(yytext) == 0)                                    a = cons(mk_str("\001"), a); /* block separator */                               else                                    a = cons(mk_str(yytext), a);' } (Indent ListBlock { raise " a = cons($$, a); " })+ { raise "  $$ = mk_str_from_list(a, false); " }
  def _ListContinuationBlock

    _save = self.pos
    while true # sequence
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      while true
        _tmp = apply(:_BlankLine)
        break unless _tmp
      end
      _tmp = true
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;    raise 'if (strlen(yytext) == 0)
                                   a = cons(mk_str("\001"), a); /* block separator */
                              else
                                   a = cons(mk_str(yytext), a);' ; end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos

      _save3 = self.pos
      while true # sequence
        _tmp = apply(:_Indent)
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = apply(:_ListBlock)
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  raise " a = cons($$, a); " ; end
        _tmp = true
        unless _tmp
          self.pos = _save3
        end
        break
      end # end sequence

      if _tmp
        while true

          _save4 = self.pos
          while true # sequence
            _tmp = apply(:_Indent)
            unless _tmp
              self.pos = _save4
              break
            end
            _tmp = apply(:_ListBlock)
            unless _tmp
              self.pos = _save4
              break
            end
            @result = begin;  raise " a = cons($$, a); " ; end
            _tmp = true
            unless _tmp
              self.pos = _save4
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save2
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise "  $$ = mk_str_from_list(a, false); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_ListContinuationBlock unless _tmp
    return _tmp
  end

  # Enumerator = NonindentSpace [0-9]+ "." Spacechar+
  def _Enumerator

    _save = self.pos
    while true # sequence
      _tmp = apply(:_NonindentSpace)
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _save2 = self.pos
      _tmp = get_byte
      if _tmp
        unless _tmp >= 48 and _tmp <= 57
          self.pos = _save2
          _tmp = nil
        end
      end
      if _tmp
        while true
          _save3 = self.pos
          _tmp = get_byte
          if _tmp
            unless _tmp >= 48 and _tmp <= 57
              self.pos = _save3
              _tmp = nil
            end
          end
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(".")
      unless _tmp
        self.pos = _save
        break
      end
      _save4 = self.pos
      _tmp = apply(:_Spacechar)
      if _tmp
        while true
          _tmp = apply(:_Spacechar)
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save4
      end
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Enumerator unless _tmp
    return _tmp
  end

  # OrderedList = &Enumerator (ListTight | ListLoose) { raise " $$->key = ORDEREDLIST; " }
  def _OrderedList

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_Enumerator)
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end

      _save2 = self.pos
      while true # choice
        _tmp = apply(:_ListTight)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_ListLoose)
        break if _tmp
        self.pos = _save2
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$->key = ORDEREDLIST; " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_OrderedList unless _tmp
    return _tmp
  end

  # ListBlockLine = !BlankLine !(Indent? (Bullet | Enumerator)) !HorizontalRule OptionallyIndentedLine
  def _ListBlockLine

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_BlankLine)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos

      _save3 = self.pos
      while true # sequence
        _save4 = self.pos
        _tmp = apply(:_Indent)
        unless _tmp
          _tmp = true
          self.pos = _save4
        end
        unless _tmp
          self.pos = _save3
          break
        end

        _save5 = self.pos
        while true # choice
          _tmp = apply(:_Bullet)
          break if _tmp
          self.pos = _save5
          _tmp = apply(:_Enumerator)
          break if _tmp
          self.pos = _save5
          break
        end # end choice

        unless _tmp
          self.pos = _save3
        end
        break
      end # end sequence

      _tmp = _tmp ? nil : true
      self.pos = _save2
      unless _tmp
        self.pos = _save
        break
      end
      _save6 = self.pos
      _tmp = apply(:_HorizontalRule)
      _tmp = _tmp ? nil : true
      self.pos = _save6
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_OptionallyIndentedLine)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_ListBlockLine unless _tmp
    return _tmp
  end

  # HtmlBlockOpenAddress = "<" Spnl ("address" | "ADDRESS") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenAddress

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("address")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("ADDRESS")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenAddress unless _tmp
    return _tmp
  end

  # HtmlBlockCloseAddress = "<" Spnl "/" ("address" | "ADDRESS") Spnl ">"
  def _HtmlBlockCloseAddress

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("address")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("ADDRESS")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseAddress unless _tmp
    return _tmp
  end

  # HtmlBlockAddress = HtmlBlockOpenAddress (HtmlBlockAddress | !HtmlBlockCloseAddress .)* HtmlBlockCloseAddress
  def _HtmlBlockAddress

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenAddress)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockAddress)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseAddress)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseAddress)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockAddress unless _tmp
    return _tmp
  end

  # HtmlBlockOpenBlockquote = "<" Spnl ("blockquote" | "BLOCKQUOTE") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenBlockquote

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("blockquote")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("BLOCKQUOTE")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenBlockquote unless _tmp
    return _tmp
  end

  # HtmlBlockCloseBlockquote = "<" Spnl "/" ("blockquote" | "BLOCKQUOTE") Spnl ">"
  def _HtmlBlockCloseBlockquote

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("blockquote")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("BLOCKQUOTE")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseBlockquote unless _tmp
    return _tmp
  end

  # HtmlBlockBlockquote = HtmlBlockOpenBlockquote (HtmlBlockBlockquote | !HtmlBlockCloseBlockquote .)* HtmlBlockCloseBlockquote
  def _HtmlBlockBlockquote

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenBlockquote)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockBlockquote)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseBlockquote)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseBlockquote)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockBlockquote unless _tmp
    return _tmp
  end

  # HtmlBlockOpenCenter = "<" Spnl ("center" | "CENTER") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenCenter

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("center")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("CENTER")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenCenter unless _tmp
    return _tmp
  end

  # HtmlBlockCloseCenter = "<" Spnl "/" ("center" | "CENTER") Spnl ">"
  def _HtmlBlockCloseCenter

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("center")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("CENTER")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseCenter unless _tmp
    return _tmp
  end

  # HtmlBlockCenter = HtmlBlockOpenCenter (HtmlBlockCenter | !HtmlBlockCloseCenter .)* HtmlBlockCloseCenter
  def _HtmlBlockCenter

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenCenter)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockCenter)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseCenter)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseCenter)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCenter unless _tmp
    return _tmp
  end

  # HtmlBlockOpenDir = "<" Spnl ("dir" | "DIR") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenDir

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("dir")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("DIR")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenDir unless _tmp
    return _tmp
  end

  # HtmlBlockCloseDir = "<" Spnl "/" ("dir" | "DIR") Spnl ">"
  def _HtmlBlockCloseDir

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("dir")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("DIR")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseDir unless _tmp
    return _tmp
  end

  # HtmlBlockDir = HtmlBlockOpenDir (HtmlBlockDir | !HtmlBlockCloseDir .)* HtmlBlockCloseDir
  def _HtmlBlockDir

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenDir)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockDir)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseDir)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseDir)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockDir unless _tmp
    return _tmp
  end

  # HtmlBlockOpenDiv = "<" Spnl ("div" | "DIV") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenDiv

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("div")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("DIV")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenDiv unless _tmp
    return _tmp
  end

  # HtmlBlockCloseDiv = "<" Spnl "/" ("div" | "DIV") Spnl ">"
  def _HtmlBlockCloseDiv

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("div")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("DIV")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseDiv unless _tmp
    return _tmp
  end

  # HtmlBlockDiv = HtmlBlockOpenDiv (HtmlBlockDiv | !HtmlBlockCloseDiv .)* HtmlBlockCloseDiv
  def _HtmlBlockDiv

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenDiv)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockDiv)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseDiv)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseDiv)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockDiv unless _tmp
    return _tmp
  end

  # HtmlBlockOpenDl = "<" Spnl ("dl" | "DL") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenDl

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("dl")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("DL")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenDl unless _tmp
    return _tmp
  end

  # HtmlBlockCloseDl = "<" Spnl "/" ("dl" | "DL") Spnl ">"
  def _HtmlBlockCloseDl

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("dl")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("DL")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseDl unless _tmp
    return _tmp
  end

  # HtmlBlockDl = HtmlBlockOpenDl (HtmlBlockDl | !HtmlBlockCloseDl .)* HtmlBlockCloseDl
  def _HtmlBlockDl

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenDl)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockDl)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseDl)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseDl)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockDl unless _tmp
    return _tmp
  end

  # HtmlBlockOpenFieldset = "<" Spnl ("fieldset" | "FIELDSET") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenFieldset

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("fieldset")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("FIELDSET")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenFieldset unless _tmp
    return _tmp
  end

  # HtmlBlockCloseFieldset = "<" Spnl "/" ("fieldset" | "FIELDSET") Spnl ">"
  def _HtmlBlockCloseFieldset

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("fieldset")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("FIELDSET")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseFieldset unless _tmp
    return _tmp
  end

  # HtmlBlockFieldset = HtmlBlockOpenFieldset (HtmlBlockFieldset | !HtmlBlockCloseFieldset .)* HtmlBlockCloseFieldset
  def _HtmlBlockFieldset

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenFieldset)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockFieldset)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseFieldset)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseFieldset)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockFieldset unless _tmp
    return _tmp
  end

  # HtmlBlockOpenForm = "<" Spnl ("form" | "FORM") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenForm

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("form")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("FORM")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenForm unless _tmp
    return _tmp
  end

  # HtmlBlockCloseForm = "<" Spnl "/" ("form" | "FORM") Spnl ">"
  def _HtmlBlockCloseForm

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("form")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("FORM")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseForm unless _tmp
    return _tmp
  end

  # HtmlBlockForm = HtmlBlockOpenForm (HtmlBlockForm | !HtmlBlockCloseForm .)* HtmlBlockCloseForm
  def _HtmlBlockForm

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenForm)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockForm)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseForm)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseForm)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockForm unless _tmp
    return _tmp
  end

  # HtmlBlockOpenH1 = "<" Spnl ("h1" | "H1") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenH1

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("h1")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("H1")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenH1 unless _tmp
    return _tmp
  end

  # HtmlBlockCloseH1 = "<" Spnl "/" ("h1" | "H1") Spnl ">"
  def _HtmlBlockCloseH1

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("h1")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("H1")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseH1 unless _tmp
    return _tmp
  end

  # HtmlBlockH1 = HtmlBlockOpenH1 (HtmlBlockH1 | !HtmlBlockCloseH1 .)* HtmlBlockCloseH1
  def _HtmlBlockH1

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenH1)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockH1)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseH1)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseH1)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockH1 unless _tmp
    return _tmp
  end

  # HtmlBlockOpenH2 = "<" Spnl ("h2" | "H2") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenH2

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("h2")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("H2")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenH2 unless _tmp
    return _tmp
  end

  # HtmlBlockCloseH2 = "<" Spnl "/" ("h2" | "H2") Spnl ">"
  def _HtmlBlockCloseH2

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("h2")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("H2")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseH2 unless _tmp
    return _tmp
  end

  # HtmlBlockH2 = HtmlBlockOpenH2 (HtmlBlockH2 | !HtmlBlockCloseH2 .)* HtmlBlockCloseH2
  def _HtmlBlockH2

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenH2)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockH2)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseH2)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseH2)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockH2 unless _tmp
    return _tmp
  end

  # HtmlBlockOpenH3 = "<" Spnl ("h3" | "H3") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenH3

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("h3")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("H3")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenH3 unless _tmp
    return _tmp
  end

  # HtmlBlockCloseH3 = "<" Spnl "/" ("h3" | "H3") Spnl ">"
  def _HtmlBlockCloseH3

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("h3")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("H3")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseH3 unless _tmp
    return _tmp
  end

  # HtmlBlockH3 = HtmlBlockOpenH3 (HtmlBlockH3 | !HtmlBlockCloseH3 .)* HtmlBlockCloseH3
  def _HtmlBlockH3

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenH3)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockH3)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseH3)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseH3)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockH3 unless _tmp
    return _tmp
  end

  # HtmlBlockOpenH4 = "<" Spnl ("h4" | "H4") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenH4

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("h4")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("H4")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenH4 unless _tmp
    return _tmp
  end

  # HtmlBlockCloseH4 = "<" Spnl "/" ("h4" | "H4") Spnl ">"
  def _HtmlBlockCloseH4

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("h4")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("H4")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseH4 unless _tmp
    return _tmp
  end

  # HtmlBlockH4 = HtmlBlockOpenH4 (HtmlBlockH4 | !HtmlBlockCloseH4 .)* HtmlBlockCloseH4
  def _HtmlBlockH4

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenH4)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockH4)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseH4)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseH4)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockH4 unless _tmp
    return _tmp
  end

  # HtmlBlockOpenH5 = "<" Spnl ("h5" | "H5") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenH5

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("h5")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("H5")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenH5 unless _tmp
    return _tmp
  end

  # HtmlBlockCloseH5 = "<" Spnl "/" ("h5" | "H5") Spnl ">"
  def _HtmlBlockCloseH5

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("h5")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("H5")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseH5 unless _tmp
    return _tmp
  end

  # HtmlBlockH5 = HtmlBlockOpenH5 (HtmlBlockH5 | !HtmlBlockCloseH5 .)* HtmlBlockCloseH5
  def _HtmlBlockH5

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenH5)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockH5)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseH5)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseH5)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockH5 unless _tmp
    return _tmp
  end

  # HtmlBlockOpenH6 = "<" Spnl ("h6" | "H6") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenH6

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("h6")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("H6")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenH6 unless _tmp
    return _tmp
  end

  # HtmlBlockCloseH6 = "<" Spnl "/" ("h6" | "H6") Spnl ">"
  def _HtmlBlockCloseH6

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("h6")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("H6")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseH6 unless _tmp
    return _tmp
  end

  # HtmlBlockH6 = HtmlBlockOpenH6 (HtmlBlockH6 | !HtmlBlockCloseH6 .)* HtmlBlockCloseH6
  def _HtmlBlockH6

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenH6)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockH6)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseH6)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseH6)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockH6 unless _tmp
    return _tmp
  end

  # HtmlBlockOpenMenu = "<" Spnl ("menu" | "MENU") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenMenu

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("menu")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("MENU")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenMenu unless _tmp
    return _tmp
  end

  # HtmlBlockCloseMenu = "<" Spnl "/" ("menu" | "MENU") Spnl ">"
  def _HtmlBlockCloseMenu

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("menu")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("MENU")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseMenu unless _tmp
    return _tmp
  end

  # HtmlBlockMenu = HtmlBlockOpenMenu (HtmlBlockMenu | !HtmlBlockCloseMenu .)* HtmlBlockCloseMenu
  def _HtmlBlockMenu

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenMenu)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockMenu)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseMenu)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseMenu)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockMenu unless _tmp
    return _tmp
  end

  # HtmlBlockOpenNoframes = "<" Spnl ("noframes" | "NOFRAMES") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenNoframes

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("noframes")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("NOFRAMES")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenNoframes unless _tmp
    return _tmp
  end

  # HtmlBlockCloseNoframes = "<" Spnl "/" ("noframes" | "NOFRAMES") Spnl ">"
  def _HtmlBlockCloseNoframes

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("noframes")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("NOFRAMES")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseNoframes unless _tmp
    return _tmp
  end

  # HtmlBlockNoframes = HtmlBlockOpenNoframes (HtmlBlockNoframes | !HtmlBlockCloseNoframes .)* HtmlBlockCloseNoframes
  def _HtmlBlockNoframes

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenNoframes)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockNoframes)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseNoframes)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseNoframes)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockNoframes unless _tmp
    return _tmp
  end

  # HtmlBlockOpenNoscript = "<" Spnl ("noscript" | "NOSCRIPT") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenNoscript

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("noscript")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("NOSCRIPT")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenNoscript unless _tmp
    return _tmp
  end

  # HtmlBlockCloseNoscript = "<" Spnl "/" ("noscript" | "NOSCRIPT") Spnl ">"
  def _HtmlBlockCloseNoscript

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("noscript")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("NOSCRIPT")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseNoscript unless _tmp
    return _tmp
  end

  # HtmlBlockNoscript = HtmlBlockOpenNoscript (HtmlBlockNoscript | !HtmlBlockCloseNoscript .)* HtmlBlockCloseNoscript
  def _HtmlBlockNoscript

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenNoscript)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockNoscript)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseNoscript)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseNoscript)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockNoscript unless _tmp
    return _tmp
  end

  # HtmlBlockOpenOl = "<" Spnl ("ol" | "OL") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenOl

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("ol")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("OL")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenOl unless _tmp
    return _tmp
  end

  # HtmlBlockCloseOl = "<" Spnl "/" ("ol" | "OL") Spnl ">"
  def _HtmlBlockCloseOl

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("ol")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("OL")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseOl unless _tmp
    return _tmp
  end

  # HtmlBlockOl = HtmlBlockOpenOl (HtmlBlockOl | !HtmlBlockCloseOl .)* HtmlBlockCloseOl
  def _HtmlBlockOl

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenOl)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockOl)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseOl)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseOl)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOl unless _tmp
    return _tmp
  end

  # HtmlBlockOpenP = "<" Spnl ("p" | "P") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenP

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("p")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("P")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenP unless _tmp
    return _tmp
  end

  # HtmlBlockCloseP = "<" Spnl "/" ("p" | "P") Spnl ">"
  def _HtmlBlockCloseP

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("p")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("P")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseP unless _tmp
    return _tmp
  end

  # HtmlBlockP = HtmlBlockOpenP (HtmlBlockP | !HtmlBlockCloseP .)* HtmlBlockCloseP
  def _HtmlBlockP

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenP)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockP)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseP)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseP)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockP unless _tmp
    return _tmp
  end

  # HtmlBlockOpenPre = "<" Spnl ("pre" | "PRE") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenPre

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("pre")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("PRE")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenPre unless _tmp
    return _tmp
  end

  # HtmlBlockClosePre = "<" Spnl "/" ("pre" | "PRE") Spnl ">"
  def _HtmlBlockClosePre

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("pre")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("PRE")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockClosePre unless _tmp
    return _tmp
  end

  # HtmlBlockPre = HtmlBlockOpenPre (HtmlBlockPre | !HtmlBlockClosePre .)* HtmlBlockClosePre
  def _HtmlBlockPre

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenPre)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockPre)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockClosePre)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockClosePre)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockPre unless _tmp
    return _tmp
  end

  # HtmlBlockOpenTable = "<" Spnl ("table" | "TABLE") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenTable

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("table")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("TABLE")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenTable unless _tmp
    return _tmp
  end

  # HtmlBlockCloseTable = "<" Spnl "/" ("table" | "TABLE") Spnl ">"
  def _HtmlBlockCloseTable

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("table")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("TABLE")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseTable unless _tmp
    return _tmp
  end

  # HtmlBlockTable = HtmlBlockOpenTable (HtmlBlockTable | !HtmlBlockCloseTable .)* HtmlBlockCloseTable
  def _HtmlBlockTable

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenTable)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockTable)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseTable)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseTable)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockTable unless _tmp
    return _tmp
  end

  # HtmlBlockOpenUl = "<" Spnl ("ul" | "UL") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenUl

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("ul")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("UL")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenUl unless _tmp
    return _tmp
  end

  # HtmlBlockCloseUl = "<" Spnl "/" ("ul" | "UL") Spnl ">"
  def _HtmlBlockCloseUl

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("ul")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("UL")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseUl unless _tmp
    return _tmp
  end

  # HtmlBlockUl = HtmlBlockOpenUl (HtmlBlockUl | !HtmlBlockCloseUl .)* HtmlBlockCloseUl
  def _HtmlBlockUl

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenUl)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockUl)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseUl)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseUl)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockUl unless _tmp
    return _tmp
  end

  # HtmlBlockOpenDd = "<" Spnl ("dd" | "DD") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenDd

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("dd")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("DD")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenDd unless _tmp
    return _tmp
  end

  # HtmlBlockCloseDd = "<" Spnl "/" ("dd" | "DD") Spnl ">"
  def _HtmlBlockCloseDd

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("dd")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("DD")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseDd unless _tmp
    return _tmp
  end

  # HtmlBlockDd = HtmlBlockOpenDd (HtmlBlockDd | !HtmlBlockCloseDd .)* HtmlBlockCloseDd
  def _HtmlBlockDd

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenDd)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockDd)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseDd)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseDd)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockDd unless _tmp
    return _tmp
  end

  # HtmlBlockOpenDt = "<" Spnl ("dt" | "DT") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenDt

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("dt")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("DT")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenDt unless _tmp
    return _tmp
  end

  # HtmlBlockCloseDt = "<" Spnl "/" ("dt" | "DT") Spnl ">"
  def _HtmlBlockCloseDt

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("dt")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("DT")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseDt unless _tmp
    return _tmp
  end

  # HtmlBlockDt = HtmlBlockOpenDt (HtmlBlockDt | !HtmlBlockCloseDt .)* HtmlBlockCloseDt
  def _HtmlBlockDt

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenDt)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockDt)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseDt)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseDt)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockDt unless _tmp
    return _tmp
  end

  # HtmlBlockOpenFrameset = "<" Spnl ("frameset" | "FRAMESET") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenFrameset

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("frameset")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("FRAMESET")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenFrameset unless _tmp
    return _tmp
  end

  # HtmlBlockCloseFrameset = "<" Spnl "/" ("frameset" | "FRAMESET") Spnl ">"
  def _HtmlBlockCloseFrameset

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("frameset")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("FRAMESET")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseFrameset unless _tmp
    return _tmp
  end

  # HtmlBlockFrameset = HtmlBlockOpenFrameset (HtmlBlockFrameset | !HtmlBlockCloseFrameset .)* HtmlBlockCloseFrameset
  def _HtmlBlockFrameset

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenFrameset)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockFrameset)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseFrameset)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseFrameset)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockFrameset unless _tmp
    return _tmp
  end

  # HtmlBlockOpenLi = "<" Spnl ("li" | "LI") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenLi

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("li")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("LI")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenLi unless _tmp
    return _tmp
  end

  # HtmlBlockCloseLi = "<" Spnl "/" ("li" | "LI") Spnl ">"
  def _HtmlBlockCloseLi

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("li")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("LI")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseLi unless _tmp
    return _tmp
  end

  # HtmlBlockLi = HtmlBlockOpenLi (HtmlBlockLi | !HtmlBlockCloseLi .)* HtmlBlockCloseLi
  def _HtmlBlockLi

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenLi)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockLi)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseLi)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseLi)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockLi unless _tmp
    return _tmp
  end

  # HtmlBlockOpenTbody = "<" Spnl ("tbody" | "TBODY") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenTbody

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("tbody")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("TBODY")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenTbody unless _tmp
    return _tmp
  end

  # HtmlBlockCloseTbody = "<" Spnl "/" ("tbody" | "TBODY") Spnl ">"
  def _HtmlBlockCloseTbody

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("tbody")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("TBODY")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseTbody unless _tmp
    return _tmp
  end

  # HtmlBlockTbody = HtmlBlockOpenTbody (HtmlBlockTbody | !HtmlBlockCloseTbody .)* HtmlBlockCloseTbody
  def _HtmlBlockTbody

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenTbody)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockTbody)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseTbody)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseTbody)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockTbody unless _tmp
    return _tmp
  end

  # HtmlBlockOpenTd = "<" Spnl ("td" | "TD") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenTd

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("td")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("TD")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenTd unless _tmp
    return _tmp
  end

  # HtmlBlockCloseTd = "<" Spnl "/" ("td" | "TD") Spnl ">"
  def _HtmlBlockCloseTd

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("td")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("TD")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseTd unless _tmp
    return _tmp
  end

  # HtmlBlockTd = HtmlBlockOpenTd (HtmlBlockTd | !HtmlBlockCloseTd .)* HtmlBlockCloseTd
  def _HtmlBlockTd

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenTd)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockTd)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseTd)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseTd)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockTd unless _tmp
    return _tmp
  end

  # HtmlBlockOpenTfoot = "<" Spnl ("tfoot" | "TFOOT") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenTfoot

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("tfoot")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("TFOOT")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenTfoot unless _tmp
    return _tmp
  end

  # HtmlBlockCloseTfoot = "<" Spnl "/" ("tfoot" | "TFOOT") Spnl ">"
  def _HtmlBlockCloseTfoot

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("tfoot")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("TFOOT")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseTfoot unless _tmp
    return _tmp
  end

  # HtmlBlockTfoot = HtmlBlockOpenTfoot (HtmlBlockTfoot | !HtmlBlockCloseTfoot .)* HtmlBlockCloseTfoot
  def _HtmlBlockTfoot

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenTfoot)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockTfoot)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseTfoot)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseTfoot)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockTfoot unless _tmp
    return _tmp
  end

  # HtmlBlockOpenTh = "<" Spnl ("th" | "TH") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenTh

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("th")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("TH")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenTh unless _tmp
    return _tmp
  end

  # HtmlBlockCloseTh = "<" Spnl "/" ("th" | "TH") Spnl ">"
  def _HtmlBlockCloseTh

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("th")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("TH")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseTh unless _tmp
    return _tmp
  end

  # HtmlBlockTh = HtmlBlockOpenTh (HtmlBlockTh | !HtmlBlockCloseTh .)* HtmlBlockCloseTh
  def _HtmlBlockTh

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenTh)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockTh)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseTh)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseTh)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockTh unless _tmp
    return _tmp
  end

  # HtmlBlockOpenThead = "<" Spnl ("thead" | "THEAD") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenThead

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("thead")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("THEAD")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenThead unless _tmp
    return _tmp
  end

  # HtmlBlockCloseThead = "<" Spnl "/" ("thead" | "THEAD") Spnl ">"
  def _HtmlBlockCloseThead

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("thead")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("THEAD")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseThead unless _tmp
    return _tmp
  end

  # HtmlBlockThead = HtmlBlockOpenThead (HtmlBlockThead | !HtmlBlockCloseThead .)* HtmlBlockCloseThead
  def _HtmlBlockThead

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenThead)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockThead)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseThead)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseThead)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockThead unless _tmp
    return _tmp
  end

  # HtmlBlockOpenTr = "<" Spnl ("tr" | "TR") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenTr

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("tr")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("TR")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenTr unless _tmp
    return _tmp
  end

  # HtmlBlockCloseTr = "<" Spnl "/" ("tr" | "TR") Spnl ">"
  def _HtmlBlockCloseTr

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("tr")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("TR")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseTr unless _tmp
    return _tmp
  end

  # HtmlBlockTr = HtmlBlockOpenTr (HtmlBlockTr | !HtmlBlockCloseTr .)* HtmlBlockCloseTr
  def _HtmlBlockTr

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenTr)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_HtmlBlockTr)
          break if _tmp
          self.pos = _save2

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = apply(:_HtmlBlockCloseTr)
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseTr)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockTr unless _tmp
    return _tmp
  end

  # HtmlBlockOpenScript = "<" Spnl ("script" | "SCRIPT") Spnl HtmlAttribute* ">"
  def _HtmlBlockOpenScript

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("script")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("SCRIPT")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockOpenScript unless _tmp
    return _tmp
  end

  # HtmlBlockCloseScript = "<" Spnl "/" ("script" | "SCRIPT") Spnl ">"
  def _HtmlBlockCloseScript

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("script")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("SCRIPT")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockCloseScript unless _tmp
    return _tmp
  end

  # HtmlBlockScript = HtmlBlockOpenScript (!HtmlBlockCloseScript .)* HtmlBlockCloseScript
  def _HtmlBlockScript

    _save = self.pos
    while true # sequence
      _tmp = apply(:_HtmlBlockOpenScript)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # sequence
          _save3 = self.pos
          _tmp = apply(:_HtmlBlockCloseScript)
          _tmp = _tmp ? nil : true
          self.pos = _save3
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = get_byte
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockCloseScript)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockScript unless _tmp
    return _tmp
  end

  # HtmlBlockInTags = (HtmlBlockAddress | HtmlBlockBlockquote | HtmlBlockCenter | HtmlBlockDir | HtmlBlockDiv | HtmlBlockDl | HtmlBlockFieldset | HtmlBlockForm | HtmlBlockH1 | HtmlBlockH2 | HtmlBlockH3 | HtmlBlockH4 | HtmlBlockH5 | HtmlBlockH6 | HtmlBlockMenu | HtmlBlockNoframes | HtmlBlockNoscript | HtmlBlockOl | HtmlBlockP | HtmlBlockPre | HtmlBlockTable | HtmlBlockUl | HtmlBlockDd | HtmlBlockDt | HtmlBlockFrameset | HtmlBlockLi | HtmlBlockTbody | HtmlBlockTd | HtmlBlockTfoot | HtmlBlockTh | HtmlBlockThead | HtmlBlockTr | HtmlBlockScript)
  def _HtmlBlockInTags

    _save = self.pos
    while true # choice
      _tmp = apply(:_HtmlBlockAddress)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockBlockquote)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockCenter)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockDir)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockDiv)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockDl)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockFieldset)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockForm)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockH1)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockH2)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockH3)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockH4)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockH5)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockH6)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockMenu)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockNoframes)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockNoscript)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockOl)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockP)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockPre)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockTable)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockUl)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockDd)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockDt)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockFrameset)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockLi)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockTbody)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockTd)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockTfoot)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockTh)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockThead)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockTr)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_HtmlBlockScript)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_HtmlBlockInTags unless _tmp
    return _tmp
  end

  # HtmlBlock = < (HtmlBlockInTags | HtmlComment | HtmlBlockSelfClosing) > BlankLine+ {   raise 'if (extension(EXT_FILTER_HTML)) {                     $$ = mk_list(LIST, NULL);                 } else {                     $$ = mk_str(yytext);                     $$->key = HTMLBLOCK;                 }'             }
  def _HtmlBlock

    _save = self.pos
    while true # sequence
      _text_start = self.pos

      _save1 = self.pos
      while true # choice
        _tmp = apply(:_HtmlBlockInTags)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_HtmlComment)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_HtmlBlockSelfClosing)
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_BlankLine)
      if _tmp
        while true
          _tmp = apply(:_BlankLine)
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save2
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;    raise 'if (extension(EXT_FILTER_HTML)) {
                    $$ = mk_list(LIST, NULL);
                } else {
                    $$ = mk_str(yytext);
                    $$->key = HTMLBLOCK;
                }'
            ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlock unless _tmp
    return _tmp
  end

  # HtmlBlockSelfClosing = "<" Spnl HtmlBlockType Spnl HtmlAttribute* "/" Spnl ">"
  def _HtmlBlockSelfClosing

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_HtmlBlockType)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlBlockSelfClosing unless _tmp
    return _tmp
  end

  # HtmlBlockType = ("address" | "blockquote" | "center" | "dir" | "div" | "dl" | "fieldset" | "form" | "h1" | "h2" | "h3" | "h4" | "h5" | "h6" | "hr" | "isindex" | "menu" | "noframes" | "noscript" | "ol" | "p" | "pre" | "table" | "ul" | "dd" | "dt" | "frameset" | "li" | "tbody" | "td" | "tfoot" | "th" | "thead" | "tr" | "script" | "ADDRESS" | "BLOCKQUOTE" | "CENTER" | "DIR" | "DIV" | "DL" | "FIELDSET" | "FORM" | "H1" | "H2" | "H3" | "H4" | "H5" | "H6" | "HR" | "ISINDEX" | "MENU" | "NOFRAMES" | "NOSCRIPT" | "OL" | "P" | "PRE" | "TABLE" | "UL" | "DD" | "DT" | "FRAMESET" | "LI" | "TBODY" | "TD" | "TFOOT" | "TH" | "THEAD" | "TR" | "SCRIPT")
  def _HtmlBlockType

    _save = self.pos
    while true # choice
      _tmp = match_string("address")
      break if _tmp
      self.pos = _save
      _tmp = match_string("blockquote")
      break if _tmp
      self.pos = _save
      _tmp = match_string("center")
      break if _tmp
      self.pos = _save
      _tmp = match_string("dir")
      break if _tmp
      self.pos = _save
      _tmp = match_string("div")
      break if _tmp
      self.pos = _save
      _tmp = match_string("dl")
      break if _tmp
      self.pos = _save
      _tmp = match_string("fieldset")
      break if _tmp
      self.pos = _save
      _tmp = match_string("form")
      break if _tmp
      self.pos = _save
      _tmp = match_string("h1")
      break if _tmp
      self.pos = _save
      _tmp = match_string("h2")
      break if _tmp
      self.pos = _save
      _tmp = match_string("h3")
      break if _tmp
      self.pos = _save
      _tmp = match_string("h4")
      break if _tmp
      self.pos = _save
      _tmp = match_string("h5")
      break if _tmp
      self.pos = _save
      _tmp = match_string("h6")
      break if _tmp
      self.pos = _save
      _tmp = match_string("hr")
      break if _tmp
      self.pos = _save
      _tmp = match_string("isindex")
      break if _tmp
      self.pos = _save
      _tmp = match_string("menu")
      break if _tmp
      self.pos = _save
      _tmp = match_string("noframes")
      break if _tmp
      self.pos = _save
      _tmp = match_string("noscript")
      break if _tmp
      self.pos = _save
      _tmp = match_string("ol")
      break if _tmp
      self.pos = _save
      _tmp = match_string("p")
      break if _tmp
      self.pos = _save
      _tmp = match_string("pre")
      break if _tmp
      self.pos = _save
      _tmp = match_string("table")
      break if _tmp
      self.pos = _save
      _tmp = match_string("ul")
      break if _tmp
      self.pos = _save
      _tmp = match_string("dd")
      break if _tmp
      self.pos = _save
      _tmp = match_string("dt")
      break if _tmp
      self.pos = _save
      _tmp = match_string("frameset")
      break if _tmp
      self.pos = _save
      _tmp = match_string("li")
      break if _tmp
      self.pos = _save
      _tmp = match_string("tbody")
      break if _tmp
      self.pos = _save
      _tmp = match_string("td")
      break if _tmp
      self.pos = _save
      _tmp = match_string("tfoot")
      break if _tmp
      self.pos = _save
      _tmp = match_string("th")
      break if _tmp
      self.pos = _save
      _tmp = match_string("thead")
      break if _tmp
      self.pos = _save
      _tmp = match_string("tr")
      break if _tmp
      self.pos = _save
      _tmp = match_string("script")
      break if _tmp
      self.pos = _save
      _tmp = match_string("ADDRESS")
      break if _tmp
      self.pos = _save
      _tmp = match_string("BLOCKQUOTE")
      break if _tmp
      self.pos = _save
      _tmp = match_string("CENTER")
      break if _tmp
      self.pos = _save
      _tmp = match_string("DIR")
      break if _tmp
      self.pos = _save
      _tmp = match_string("DIV")
      break if _tmp
      self.pos = _save
      _tmp = match_string("DL")
      break if _tmp
      self.pos = _save
      _tmp = match_string("FIELDSET")
      break if _tmp
      self.pos = _save
      _tmp = match_string("FORM")
      break if _tmp
      self.pos = _save
      _tmp = match_string("H1")
      break if _tmp
      self.pos = _save
      _tmp = match_string("H2")
      break if _tmp
      self.pos = _save
      _tmp = match_string("H3")
      break if _tmp
      self.pos = _save
      _tmp = match_string("H4")
      break if _tmp
      self.pos = _save
      _tmp = match_string("H5")
      break if _tmp
      self.pos = _save
      _tmp = match_string("H6")
      break if _tmp
      self.pos = _save
      _tmp = match_string("HR")
      break if _tmp
      self.pos = _save
      _tmp = match_string("ISINDEX")
      break if _tmp
      self.pos = _save
      _tmp = match_string("MENU")
      break if _tmp
      self.pos = _save
      _tmp = match_string("NOFRAMES")
      break if _tmp
      self.pos = _save
      _tmp = match_string("NOSCRIPT")
      break if _tmp
      self.pos = _save
      _tmp = match_string("OL")
      break if _tmp
      self.pos = _save
      _tmp = match_string("P")
      break if _tmp
      self.pos = _save
      _tmp = match_string("PRE")
      break if _tmp
      self.pos = _save
      _tmp = match_string("TABLE")
      break if _tmp
      self.pos = _save
      _tmp = match_string("UL")
      break if _tmp
      self.pos = _save
      _tmp = match_string("DD")
      break if _tmp
      self.pos = _save
      _tmp = match_string("DT")
      break if _tmp
      self.pos = _save
      _tmp = match_string("FRAMESET")
      break if _tmp
      self.pos = _save
      _tmp = match_string("LI")
      break if _tmp
      self.pos = _save
      _tmp = match_string("TBODY")
      break if _tmp
      self.pos = _save
      _tmp = match_string("TD")
      break if _tmp
      self.pos = _save
      _tmp = match_string("TFOOT")
      break if _tmp
      self.pos = _save
      _tmp = match_string("TH")
      break if _tmp
      self.pos = _save
      _tmp = match_string("THEAD")
      break if _tmp
      self.pos = _save
      _tmp = match_string("TR")
      break if _tmp
      self.pos = _save
      _tmp = match_string("SCRIPT")
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_HtmlBlockType unless _tmp
    return _tmp
  end

  # StyleOpen = "<" Spnl ("style" | "STYLE") Spnl HtmlAttribute* ">"
  def _StyleOpen

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("style")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("STYLE")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_StyleOpen unless _tmp
    return _tmp
  end

  # StyleClose = "<" Spnl "/" ("style" | "STYLE") Spnl ">"
  def _StyleClose

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = match_string("style")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("STYLE")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_StyleClose unless _tmp
    return _tmp
  end

  # InStyleTags = StyleOpen (!StyleClose .)* StyleClose
  def _InStyleTags

    _save = self.pos
    while true # sequence
      _tmp = apply(:_StyleOpen)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # sequence
          _save3 = self.pos
          _tmp = apply(:_StyleClose)
          _tmp = _tmp ? nil : true
          self.pos = _save3
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = get_byte
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StyleClose)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_InStyleTags unless _tmp
    return _tmp
  end

  # StyleBlock = < InStyleTags > BlankLine* {   raise 'if (extension(EXT_FILTER_STYLES)) {                         $$ = mk_list(LIST, NULL);                     } else {                         $$ = mk_str(yytext);                         $$->key = HTMLBLOCK;                     }'                 }
  def _StyleBlock

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _tmp = apply(:_InStyleTags)
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_BlankLine)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;    raise 'if (extension(EXT_FILTER_STYLES)) {
                        $$ = mk_list(LIST, NULL);
                    } else {
                        $$ = mk_str(yytext);
                        $$->key = HTMLBLOCK;
                    }'
                ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_StyleBlock unless _tmp
    return _tmp
  end

  # Inlines = StartList:a (!Endline Inline:i { a = [i, a] } | Endline:c &Inline { raise " a = cons(c, a); " })+ Endline? { [:LIST, a] }
  def _Inlines

    _save = self.pos
    while true # sequence
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos

      _save2 = self.pos
      while true # choice

        _save3 = self.pos
        while true # sequence
          _save4 = self.pos
          _tmp = apply(:_Endline)
          _tmp = _tmp ? nil : true
          self.pos = _save4
          unless _tmp
            self.pos = _save3
            break
          end
          _tmp = apply(:_Inline)
          i = @result
          unless _tmp
            self.pos = _save3
            break
          end
          @result = begin;  a = [i, a] ; end
          _tmp = true
          unless _tmp
            self.pos = _save3
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save2

        _save5 = self.pos
        while true # sequence
          _tmp = apply(:_Endline)
          c = @result
          unless _tmp
            self.pos = _save5
            break
          end
          _save6 = self.pos
          _tmp = apply(:_Inline)
          self.pos = _save6
          unless _tmp
            self.pos = _save5
            break
          end
          @result = begin;  raise " a = cons(c, a); " ; end
          _tmp = true
          unless _tmp
            self.pos = _save5
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save2
        break
      end # end choice

      if _tmp
        while true

          _save7 = self.pos
          while true # choice

            _save8 = self.pos
            while true # sequence
              _save9 = self.pos
              _tmp = apply(:_Endline)
              _tmp = _tmp ? nil : true
              self.pos = _save9
              unless _tmp
                self.pos = _save8
                break
              end
              _tmp = apply(:_Inline)
              i = @result
              unless _tmp
                self.pos = _save8
                break
              end
              @result = begin;  a = [i, a] ; end
              _tmp = true
              unless _tmp
                self.pos = _save8
              end
              break
            end # end sequence

            break if _tmp
            self.pos = _save7

            _save10 = self.pos
            while true # sequence
              _tmp = apply(:_Endline)
              c = @result
              unless _tmp
                self.pos = _save10
                break
              end
              _save11 = self.pos
              _tmp = apply(:_Inline)
              self.pos = _save11
              unless _tmp
                self.pos = _save10
                break
              end
              @result = begin;  raise " a = cons(c, a); " ; end
              _tmp = true
              unless _tmp
                self.pos = _save10
              end
              break
            end # end sequence

            break if _tmp
            self.pos = _save7
            break
          end # end choice

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _save12 = self.pos
      _tmp = apply(:_Endline)
      unless _tmp
        _tmp = true
        self.pos = _save12
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  [:LIST, a] ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Inlines unless _tmp
    return _tmp
  end

  # Inline = (Str | Endline | UlOrStarLine | Space | Strong | Emph | Image | Link | NoteReference | InlineNote | Code | RawHtml | Entity | EscapedChar | Smart | Symbol)
  def _Inline

    _save = self.pos
    while true # choice
      _tmp = apply(:_Str)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_Endline)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_UlOrStarLine)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_Space)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_Strong)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_Emph)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_Image)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_Link)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_NoteReference)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_InlineNote)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_Code)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_RawHtml)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_Entity)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_EscapedChar)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_Smart)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_Symbol)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_Inline unless _tmp
    return _tmp
  end

  # Space = Spacechar+ { '$$ = mk_str(" ");           $$->key = SPACE;';           " " }
  def _Space

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_Spacechar)
      if _tmp
        while true
          _tmp = apply(:_Spacechar)
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  '$$ = mk_str(" ");
          $$->key = SPACE;';
          " " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Space unless _tmp
    return _tmp
  end

  # Str = StartList:a < NormalChar+ > { a = [text, a] } (StrChunk { raise " a = cons($$, a); " })* { !a[0] ? a : [:LIST, a] }
  def _Str

    _save = self.pos
    while true # sequence
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      _save1 = self.pos
      _tmp = apply(:_NormalChar)
      if _tmp
        while true
          _tmp = apply(:_NormalChar)
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  a = [text, a] ; end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save3 = self.pos
        while true # sequence
          _tmp = apply(:_StrChunk)
          unless _tmp
            self.pos = _save3
            break
          end
          @result = begin;  raise " a = cons($$, a); " ; end
          _tmp = true
          unless _tmp
            self.pos = _save3
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  !a[0] ? a : [:LIST, a] ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Str unless _tmp
    return _tmp
  end

  # StrChunk = (< (NormalChar | "_"+ &Alphanumeric)+ > { raise " $$ = mk_str(yytext); " } | AposChunk)
  def _StrChunk

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _text_start = self.pos
        _save2 = self.pos

        _save3 = self.pos
        while true # choice
          _tmp = apply(:_NormalChar)
          break if _tmp
          self.pos = _save3

          _save4 = self.pos
          while true # sequence
            _save5 = self.pos
            _tmp = match_string("_")
            if _tmp
              while true
                _tmp = match_string("_")
                break unless _tmp
              end
              _tmp = true
            else
              self.pos = _save5
            end
            unless _tmp
              self.pos = _save4
              break
            end
            _save6 = self.pos
            _tmp = apply(:_Alphanumeric)
            self.pos = _save6
            unless _tmp
              self.pos = _save4
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save3
          break
        end # end choice

        if _tmp
          while true

            _save7 = self.pos
            while true # choice
              _tmp = apply(:_NormalChar)
              break if _tmp
              self.pos = _save7

              _save8 = self.pos
              while true # sequence
                _save9 = self.pos
                _tmp = match_string("_")
                if _tmp
                  while true
                    _tmp = match_string("_")
                    break unless _tmp
                  end
                  _tmp = true
                else
                  self.pos = _save9
                end
                unless _tmp
                  self.pos = _save8
                  break
                end
                _save10 = self.pos
                _tmp = apply(:_Alphanumeric)
                self.pos = _save10
                unless _tmp
                  self.pos = _save8
                end
                break
              end # end sequence

              break if _tmp
              self.pos = _save7
              break
            end # end choice

            break unless _tmp
          end
          _tmp = true
        else
          self.pos = _save2
        end
        if _tmp
          text = get_text(_text_start)
        end
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  raise " $$ = mk_str(yytext); " ; end
        _tmp = true
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      _tmp = apply(:_AposChunk)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_StrChunk unless _tmp
    return _tmp
  end

  # AposChunk = &{  extension(:EXT_SMART)  } "'" &Alphanumeric { raise " $$ = mk_element(APOSTROPHE); " }
  def _AposChunk

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = begin;   extension(:EXT_SMART)  ; end
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("'")
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_Alphanumeric)
      self.pos = _save2
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_element(APOSTROPHE); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_AposChunk unless _tmp
    return _tmp
  end

  # EscapedChar = "\\" !Newline < /[-\\`|*_{}[\]()#+.!><]/ > { raise " $$ = mk_str(yytext); " }
  def _EscapedChar

    _save = self.pos
    while true # sequence
      _tmp = match_string("\\")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_Newline)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      _tmp = scan(/\A(?-mix:[-\\`|*_{}[\]()#+.!><])/)
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_str(yytext); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_EscapedChar unless _tmp
    return _tmp
  end

  # Entity = (HexEntity | DecEntity | CharEntity) { raise " $$ = mk_str(yytext); $$->key = HTML; " }
  def _Entity

    _save = self.pos
    while true # sequence

      _save1 = self.pos
      while true # choice
        _tmp = apply(:_HexEntity)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_DecEntity)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_CharEntity)
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_str(yytext); $$->key = HTML; " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Entity unless _tmp
    return _tmp
  end

  # Endline = (LineBreak | TerminalEndline | NormalEndline)
  def _Endline

    _save = self.pos
    while true # choice
      _tmp = apply(:_LineBreak)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_TerminalEndline)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_NormalEndline)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_Endline unless _tmp
    return _tmp
  end

  # NormalEndline = Sp Newline !BlankLine !">" !AtxStart !(Line ("===" "="* | "---" "-"*) Newline) { raise '$$ = mk_str("\n");                     $$->key = SPACE;' }
  def _NormalEndline

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Newline)
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_BlankLine)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = match_string(">")
      _tmp = _tmp ? nil : true
      self.pos = _save2
      unless _tmp
        self.pos = _save
        break
      end
      _save3 = self.pos
      _tmp = apply(:_AtxStart)
      _tmp = _tmp ? nil : true
      self.pos = _save3
      unless _tmp
        self.pos = _save
        break
      end
      _save4 = self.pos

      _save5 = self.pos
      while true # sequence
        _tmp = apply(:_Line)
        unless _tmp
          self.pos = _save5
          break
        end

        _save6 = self.pos
        while true # choice

          _save7 = self.pos
          while true # sequence
            _tmp = match_string("===")
            unless _tmp
              self.pos = _save7
              break
            end
            while true
              _tmp = match_string("=")
              break unless _tmp
            end
            _tmp = true
            unless _tmp
              self.pos = _save7
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save6

          _save9 = self.pos
          while true # sequence
            _tmp = match_string("---")
            unless _tmp
              self.pos = _save9
              break
            end
            while true
              _tmp = match_string("-")
              break unless _tmp
            end
            _tmp = true
            unless _tmp
              self.pos = _save9
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save6
          break
        end # end choice

        unless _tmp
          self.pos = _save5
          break
        end
        _tmp = apply(:_Newline)
        unless _tmp
          self.pos = _save5
        end
        break
      end # end sequence

      _tmp = _tmp ? nil : true
      self.pos = _save4
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise '$$ = mk_str("\n");
                    $$->key = SPACE;' ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_NormalEndline unless _tmp
    return _tmp
  end

  # TerminalEndline = Sp Newline Eof { raise " $$ = NULL; " }
  def _TerminalEndline

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Newline)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Eof)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = NULL; " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_TerminalEndline unless _tmp
    return _tmp
  end

  # LineBreak = "  " NormalEndline { raise " $$ = mk_element(LINEBREAK); " }
  def _LineBreak

    _save = self.pos
    while true # sequence
      _tmp = match_string("  ")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_NormalEndline)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_element(LINEBREAK); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_LineBreak unless _tmp
    return _tmp
  end

  # Symbol = < SpecialChar > { raise " $$ = mk_str(yytext); " }
  def _Symbol

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _tmp = apply(:_SpecialChar)
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_str(yytext); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Symbol unless _tmp
    return _tmp
  end

  # UlOrStarLine = (UlLine | StarLine) { raise " $$ = mk_str(yytext); " }
  def _UlOrStarLine

    _save = self.pos
    while true # sequence

      _save1 = self.pos
      while true # choice
        _tmp = apply(:_UlLine)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_StarLine)
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_str(yytext); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_UlOrStarLine unless _tmp
    return _tmp
  end

  # StarLine = (< "****" "*"* > | < Spacechar "*"+ &Spacechar >)
  def _StarLine

    _save = self.pos
    while true # choice
      _text_start = self.pos

      _save1 = self.pos
      while true # sequence
        _tmp = match_string("****")
        unless _tmp
          self.pos = _save1
          break
        end
        while true
          _tmp = match_string("*")
          break unless _tmp
        end
        _tmp = true
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      if _tmp
        text = get_text(_text_start)
      end
      break if _tmp
      self.pos = _save
      _text_start = self.pos

      _save3 = self.pos
      while true # sequence
        _tmp = apply(:_Spacechar)
        unless _tmp
          self.pos = _save3
          break
        end
        _save4 = self.pos
        _tmp = match_string("*")
        if _tmp
          while true
            _tmp = match_string("*")
            break unless _tmp
          end
          _tmp = true
        else
          self.pos = _save4
        end
        unless _tmp
          self.pos = _save3
          break
        end
        _save5 = self.pos
        _tmp = apply(:_Spacechar)
        self.pos = _save5
        unless _tmp
          self.pos = _save3
        end
        break
      end # end sequence

      if _tmp
        text = get_text(_text_start)
      end
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_StarLine unless _tmp
    return _tmp
  end

  # UlLine = (< "____" "_"* > | < Spacechar "_"+ &Spacechar >)
  def _UlLine

    _save = self.pos
    while true # choice
      _text_start = self.pos

      _save1 = self.pos
      while true # sequence
        _tmp = match_string("____")
        unless _tmp
          self.pos = _save1
          break
        end
        while true
          _tmp = match_string("_")
          break unless _tmp
        end
        _tmp = true
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      if _tmp
        text = get_text(_text_start)
      end
      break if _tmp
      self.pos = _save
      _text_start = self.pos

      _save3 = self.pos
      while true # sequence
        _tmp = apply(:_Spacechar)
        unless _tmp
          self.pos = _save3
          break
        end
        _save4 = self.pos
        _tmp = match_string("_")
        if _tmp
          while true
            _tmp = match_string("_")
            break unless _tmp
          end
          _tmp = true
        else
          self.pos = _save4
        end
        unless _tmp
          self.pos = _save3
          break
        end
        _save5 = self.pos
        _tmp = apply(:_Spacechar)
        self.pos = _save5
        unless _tmp
          self.pos = _save3
        end
        break
      end # end sequence

      if _tmp
        text = get_text(_text_start)
      end
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_UlLine unless _tmp
    return _tmp
  end

  # Emph = (EmphStar | EmphUl)
  def _Emph

    _save = self.pos
    while true # choice
      _tmp = apply(:_EmphStar)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_EmphUl)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_Emph unless _tmp
    return _tmp
  end

  # OneStarOpen = !StarLine "*" !Spacechar !Newline
  def _OneStarOpen

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_StarLine)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("*")
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_Spacechar)
      _tmp = _tmp ? nil : true
      self.pos = _save2
      unless _tmp
        self.pos = _save
        break
      end
      _save3 = self.pos
      _tmp = apply(:_Newline)
      _tmp = _tmp ? nil : true
      self.pos = _save3
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_OneStarOpen unless _tmp
    return _tmp
  end

  # OneStarClose = !Spacechar !Newline a:inline !StrongStar "*" { raise " $$ = a; " }
  def _OneStarClose

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_Spacechar)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_Newline)
      _tmp = _tmp ? nil : true
      self.pos = _save2
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_a)
      inline = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save3 = self.pos
      _tmp = apply(:_StrongStar)
      _tmp = _tmp ? nil : true
      self.pos = _save3
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("*")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = a; " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_OneStarClose unless _tmp
    return _tmp
  end

  # EmphStar = OneStarOpen StartList:a (!OneStarClose Inline { raise " a = cons($$, a); " })* OneStarClose { raise " a = cons($$, a); " } { raise " $$ = mk_list(EMPH, a); " }
  def _EmphStar

    _save = self.pos
    while true # sequence
      _tmp = apply(:_OneStarOpen)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # sequence
          _save3 = self.pos
          _tmp = apply(:_OneStarClose)
          _tmp = _tmp ? nil : true
          self.pos = _save3
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = apply(:_Inline)
          unless _tmp
            self.pos = _save2
            break
          end
          @result = begin;  raise " a = cons($$, a); " ; end
          _tmp = true
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_OneStarClose)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " a = cons($$, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_list(EMPH, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_EmphStar unless _tmp
    return _tmp
  end

  # OneUlOpen = !UlLine "_" !Spacechar !Newline
  def _OneUlOpen

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_UlLine)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("_")
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_Spacechar)
      _tmp = _tmp ? nil : true
      self.pos = _save2
      unless _tmp
        self.pos = _save
        break
      end
      _save3 = self.pos
      _tmp = apply(:_Newline)
      _tmp = _tmp ? nil : true
      self.pos = _save3
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_OneUlOpen unless _tmp
    return _tmp
  end

  # OneUlClose = !Spacechar !Newline a:inline !StrongUl "_" !Alphanumeric { raise " $$ = a; " }
  def _OneUlClose

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_Spacechar)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_Newline)
      _tmp = _tmp ? nil : true
      self.pos = _save2
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_a)
      inline = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save3 = self.pos
      _tmp = apply(:_StrongUl)
      _tmp = _tmp ? nil : true
      self.pos = _save3
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("_")
      unless _tmp
        self.pos = _save
        break
      end
      _save4 = self.pos
      _tmp = apply(:_Alphanumeric)
      _tmp = _tmp ? nil : true
      self.pos = _save4
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = a; " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_OneUlClose unless _tmp
    return _tmp
  end

  # EmphUl = OneUlOpen StartList:a (!OneUlClose Inline { raise " a = cons($$, a); " })* OneUlClose { raise " a = cons($$, a); " } { raise " $$ = mk_list(EMPH, a); " }
  def _EmphUl

    _save = self.pos
    while true # sequence
      _tmp = apply(:_OneUlOpen)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # sequence
          _save3 = self.pos
          _tmp = apply(:_OneUlClose)
          _tmp = _tmp ? nil : true
          self.pos = _save3
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = apply(:_Inline)
          unless _tmp
            self.pos = _save2
            break
          end
          @result = begin;  raise " a = cons($$, a); " ; end
          _tmp = true
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_OneUlClose)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " a = cons($$, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_list(EMPH, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_EmphUl unless _tmp
    return _tmp
  end

  # Strong = (StrongStar | StrongUl)
  def _Strong

    _save = self.pos
    while true # choice
      _tmp = apply(:_StrongStar)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_StrongUl)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_Strong unless _tmp
    return _tmp
  end

  # TwoStarOpen = !StarLine "**" !Spacechar !Newline
  def _TwoStarOpen

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_StarLine)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("**")
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_Spacechar)
      _tmp = _tmp ? nil : true
      self.pos = _save2
      unless _tmp
        self.pos = _save
        break
      end
      _save3 = self.pos
      _tmp = apply(:_Newline)
      _tmp = _tmp ? nil : true
      self.pos = _save3
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_TwoStarOpen unless _tmp
    return _tmp
  end

  # TwoStarClose = !Spacechar !Newline a:inline "**" { raise " $$ = a; " }
  def _TwoStarClose

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_Spacechar)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_Newline)
      _tmp = _tmp ? nil : true
      self.pos = _save2
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_a)
      inline = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("**")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = a; " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_TwoStarClose unless _tmp
    return _tmp
  end

  # StrongStar = TwoStarOpen StartList:a (!TwoStarClose Inline { raise " a = cons($$, a); " })* TwoStarClose { raise " a = cons($$, a); " } { raise " $$ = mk_list(STRONG, a); " }
  def _StrongStar

    _save = self.pos
    while true # sequence
      _tmp = apply(:_TwoStarOpen)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # sequence
          _save3 = self.pos
          _tmp = apply(:_TwoStarClose)
          _tmp = _tmp ? nil : true
          self.pos = _save3
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = apply(:_Inline)
          unless _tmp
            self.pos = _save2
            break
          end
          @result = begin;  raise " a = cons($$, a); " ; end
          _tmp = true
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_TwoStarClose)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " a = cons($$, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_list(STRONG, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_StrongStar unless _tmp
    return _tmp
  end

  # TwoUlOpen = !UlLine "__" !Spacechar !Newline
  def _TwoUlOpen

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_UlLine)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("__")
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_Spacechar)
      _tmp = _tmp ? nil : true
      self.pos = _save2
      unless _tmp
        self.pos = _save
        break
      end
      _save3 = self.pos
      _tmp = apply(:_Newline)
      _tmp = _tmp ? nil : true
      self.pos = _save3
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_TwoUlOpen unless _tmp
    return _tmp
  end

  # TwoUlClose = !Spacechar !Newline a:inline "__" !Alphanumeric { raise " $$ = a; " }
  def _TwoUlClose

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_Spacechar)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_Newline)
      _tmp = _tmp ? nil : true
      self.pos = _save2
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_a)
      inline = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("__")
      unless _tmp
        self.pos = _save
        break
      end
      _save3 = self.pos
      _tmp = apply(:_Alphanumeric)
      _tmp = _tmp ? nil : true
      self.pos = _save3
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = a; " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_TwoUlClose unless _tmp
    return _tmp
  end

  # StrongUl = TwoUlOpen StartList:a (!TwoUlClose Inline { raise " a = cons($$, a); " })* TwoUlClose { raise " a = cons($$, a); " } { raise " $$ = mk_list(STRONG, a); " }
  def _StrongUl

    _save = self.pos
    while true # sequence
      _tmp = apply(:_TwoUlOpen)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # sequence
          _save3 = self.pos
          _tmp = apply(:_TwoUlClose)
          _tmp = _tmp ? nil : true
          self.pos = _save3
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = apply(:_Inline)
          unless _tmp
            self.pos = _save2
            break
          end
          @result = begin;  raise " a = cons($$, a); " ; end
          _tmp = true
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_TwoUlClose)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " a = cons($$, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_list(STRONG, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_StrongUl unless _tmp
    return _tmp
  end

  # Image = "!" (ExplicitLink | ReferenceLink) { raise 'if ($$->key == LINK) {               $$->key = IMAGE;           } else {               element *result;               result = $$;               $$->children = cons(mk_str("!"), result->children);           } ' }
  def _Image

    _save = self.pos
    while true # sequence
      _tmp = match_string("!")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = apply(:_ExplicitLink)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_ReferenceLink)
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise 'if ($$->key == LINK) {
              $$->key = IMAGE;
          } else {
              element *result;
              result = $$;
              $$->children = cons(mk_str("!"), result->children);
          } ' ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Image unless _tmp
    return _tmp
  end

  # Link = (ExplicitLink | ReferenceLink | AutoLink)
  def _Link

    _save = self.pos
    while true # choice
      _tmp = apply(:_ExplicitLink)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_ReferenceLink)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_AutoLink)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_Link unless _tmp
    return _tmp
  end

  # ReferenceLink = (ReferenceLinkDouble | ReferenceLinkSingle)
  def _ReferenceLink

    _save = self.pos
    while true # choice
      _tmp = apply(:_ReferenceLinkDouble)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_ReferenceLinkSingle)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_ReferenceLink unless _tmp
    return _tmp
  end

  # ReferenceLinkDouble = Label:a < Spnl > !"[]" Label:b {   raise 'link match;                            if (find_reference(&match, b->children)) {                                $$ = mk_link(a->children, match.url, match.title);                                free(a);                                free_element_list(b);                            } else {                                element *result;                                result = mk_element(LIST);                                result->children = cons(mk_str("["), cons(a, cons(mk_str("]"), cons(mk_str(yytext),                                                    cons(mk_str("["), cons(b, mk_str("]")))))));                                $$ = result;                            }                            '                        }
  def _ReferenceLinkDouble

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Label)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      _tmp = apply(:_Spnl)
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = match_string("[]")
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Label)
      b = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;    raise 'link match;
                           if (find_reference(&match, b->children)) {
                               $$ = mk_link(a->children, match.url, match.title);
                               free(a);
                               free_element_list(b);
                           } else {
                               element *result;
                               result = mk_element(LIST);
                               result->children = cons(mk_str("["), cons(a, cons(mk_str("]"), cons(mk_str(yytext),
                                                   cons(mk_str("["), cons(b, mk_str("]")))))));
                               $$ = result;
                           }
                           '
                       ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_ReferenceLinkDouble unless _tmp
    return _tmp
  end

  # ReferenceLinkSingle = Label:a < (Spnl "[]")? > {   raise 'link match;                            if (find_reference(&match, a->children)) {                                $$ = mk_link(a->children, match.url, match.title);                                free(a);                            }                            else {                                element *result;                                result = mk_element(LIST);                                result->children = cons(mk_str("["), cons(a, cons(mk_str("]"), mk_str(yytext))));                                $$ = result;                            }'                        }
  def _ReferenceLinkSingle

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Label)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _tmp = apply(:_Spnl)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = match_string("[]")
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;    raise 'link match;
                           if (find_reference(&match, a->children)) {
                               $$ = mk_link(a->children, match.url, match.title);
                               free(a);
                           }
                           else {
                               element *result;
                               result = mk_element(LIST);
                               result->children = cons(mk_str("["), cons(a, cons(mk_str("]"), mk_str(yytext))));
                               $$ = result;
                           }'
                       ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_ReferenceLinkSingle unless _tmp
    return _tmp
  end

  # ExplicitLink = Label:l Spnl "(" Sp Source:s Spnl Title:t Sp ")" { raise '$$ = mk_link(l->children, s->contents.str, t->contents.str);                   free_element(s);                   free_element(t);                   free(l);' }
  def _ExplicitLink

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Label)
      l = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("(")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Source)
      s = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Title)
      t = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(")")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise '$$ = mk_link(l->children, s->contents.str, t->contents.str);
                  free_element(s);
                  free_element(t);
                  free(l);' ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_ExplicitLink unless _tmp
    return _tmp
  end

  # Source = ("<" < SourceContents > ">" | < SourceContents >) { raise " $$ = mk_str(yytext); " }
  def _Source

    _save = self.pos
    while true # sequence

      _save1 = self.pos
      while true # choice

        _save2 = self.pos
        while true # sequence
          _tmp = match_string("<")
          unless _tmp
            self.pos = _save2
            break
          end
          _text_start = self.pos
          _tmp = apply(:_SourceContents)
          if _tmp
            text = get_text(_text_start)
          end
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = match_string(">")
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save1
        _text_start = self.pos
        _tmp = apply(:_SourceContents)
        if _tmp
          text = get_text(_text_start)
        end
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_str(yytext); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Source unless _tmp
    return _tmp
  end

  # SourceContents = (((!"(" !")" !">" Nonspacechar)+ | "(" SourceContents ")")* | "")
  def _SourceContents

    _save = self.pos
    while true # choice
      while true

        _save2 = self.pos
        while true # choice
          _save3 = self.pos

          _save4 = self.pos
          while true # sequence
            _save5 = self.pos
            _tmp = match_string("(")
            _tmp = _tmp ? nil : true
            self.pos = _save5
            unless _tmp
              self.pos = _save4
              break
            end
            _save6 = self.pos
            _tmp = match_string(")")
            _tmp = _tmp ? nil : true
            self.pos = _save6
            unless _tmp
              self.pos = _save4
              break
            end
            _save7 = self.pos
            _tmp = match_string(">")
            _tmp = _tmp ? nil : true
            self.pos = _save7
            unless _tmp
              self.pos = _save4
              break
            end
            _tmp = apply(:_Nonspacechar)
            unless _tmp
              self.pos = _save4
            end
            break
          end # end sequence

          if _tmp
            while true

              _save8 = self.pos
              while true # sequence
                _save9 = self.pos
                _tmp = match_string("(")
                _tmp = _tmp ? nil : true
                self.pos = _save9
                unless _tmp
                  self.pos = _save8
                  break
                end
                _save10 = self.pos
                _tmp = match_string(")")
                _tmp = _tmp ? nil : true
                self.pos = _save10
                unless _tmp
                  self.pos = _save8
                  break
                end
                _save11 = self.pos
                _tmp = match_string(">")
                _tmp = _tmp ? nil : true
                self.pos = _save11
                unless _tmp
                  self.pos = _save8
                  break
                end
                _tmp = apply(:_Nonspacechar)
                unless _tmp
                  self.pos = _save8
                end
                break
              end # end sequence

              break unless _tmp
            end
            _tmp = true
          else
            self.pos = _save3
          end
          break if _tmp
          self.pos = _save2

          _save12 = self.pos
          while true # sequence
            _tmp = match_string("(")
            unless _tmp
              self.pos = _save12
              break
            end
            _tmp = apply(:_SourceContents)
            unless _tmp
              self.pos = _save12
              break
            end
            _tmp = match_string(")")
            unless _tmp
              self.pos = _save12
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      break if _tmp
      self.pos = _save
      _tmp = match_string("")
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_SourceContents unless _tmp
    return _tmp
  end

  # Title = (TitleSingle | TitleDouble | < "" >) { raise " $$ = mk_str(yytext); " }
  def _Title

    _save = self.pos
    while true # sequence

      _save1 = self.pos
      while true # choice
        _tmp = apply(:_TitleSingle)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_TitleDouble)
        break if _tmp
        self.pos = _save1
        _text_start = self.pos
        _tmp = match_string("")
        if _tmp
          text = get_text(_text_start)
        end
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_str(yytext); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Title unless _tmp
    return _tmp
  end

  # TitleSingle = "'" < (!("'" Sp (")" | Newline)) .)* > "'"
  def _TitleSingle

    _save = self.pos
    while true # sequence
      _tmp = match_string("'")
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      while true

        _save2 = self.pos
        while true # sequence
          _save3 = self.pos

          _save4 = self.pos
          while true # sequence
            _tmp = match_string("'")
            unless _tmp
              self.pos = _save4
              break
            end
            _tmp = apply(:_Sp)
            unless _tmp
              self.pos = _save4
              break
            end

            _save5 = self.pos
            while true # choice
              _tmp = match_string(")")
              break if _tmp
              self.pos = _save5
              _tmp = apply(:_Newline)
              break if _tmp
              self.pos = _save5
              break
            end # end choice

            unless _tmp
              self.pos = _save4
            end
            break
          end # end sequence

          _tmp = _tmp ? nil : true
          self.pos = _save3
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = get_byte
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("'")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_TitleSingle unless _tmp
    return _tmp
  end

  # TitleDouble = "\"" < (!("\"" Sp (")" | Newline)) .)* > "\""
  def _TitleDouble

    _save = self.pos
    while true # sequence
      _tmp = match_string("\"")
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      while true

        _save2 = self.pos
        while true # sequence
          _save3 = self.pos

          _save4 = self.pos
          while true # sequence
            _tmp = match_string("\"")
            unless _tmp
              self.pos = _save4
              break
            end
            _tmp = apply(:_Sp)
            unless _tmp
              self.pos = _save4
              break
            end

            _save5 = self.pos
            while true # choice
              _tmp = match_string(")")
              break if _tmp
              self.pos = _save5
              _tmp = apply(:_Newline)
              break if _tmp
              self.pos = _save5
              break
            end # end choice

            unless _tmp
              self.pos = _save4
            end
            break
          end # end sequence

          _tmp = _tmp ? nil : true
          self.pos = _save3
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = get_byte
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("\"")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_TitleDouble unless _tmp
    return _tmp
  end

  # AutoLink = (AutoLinkUrl | AutoLinkEmail)
  def _AutoLink

    _save = self.pos
    while true # choice
      _tmp = apply(:_AutoLinkUrl)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_AutoLinkEmail)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_AutoLink unless _tmp
    return _tmp
  end

  # AutoLinkUrl = "<" < /[A-Za-z]+/ "://" (!Newline !">" .)+ > ">" { raise "   $$ = mk_link(mk_str(yytext), yytext, ""); " }
  def _AutoLinkUrl

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos

      _save1 = self.pos
      while true # sequence
        _tmp = scan(/\A(?-mix:[A-Za-z]+)/)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = match_string("://")
        unless _tmp
          self.pos = _save1
          break
        end
        _save2 = self.pos

        _save3 = self.pos
        while true # sequence
          _save4 = self.pos
          _tmp = apply(:_Newline)
          _tmp = _tmp ? nil : true
          self.pos = _save4
          unless _tmp
            self.pos = _save3
            break
          end
          _save5 = self.pos
          _tmp = match_string(">")
          _tmp = _tmp ? nil : true
          self.pos = _save5
          unless _tmp
            self.pos = _save3
            break
          end
          _tmp = get_byte
          unless _tmp
            self.pos = _save3
          end
          break
        end # end sequence

        if _tmp
          while true

            _save6 = self.pos
            while true # sequence
              _save7 = self.pos
              _tmp = apply(:_Newline)
              _tmp = _tmp ? nil : true
              self.pos = _save7
              unless _tmp
                self.pos = _save6
                break
              end
              _save8 = self.pos
              _tmp = match_string(">")
              _tmp = _tmp ? nil : true
              self.pos = _save8
              unless _tmp
                self.pos = _save6
                break
              end
              _tmp = get_byte
              unless _tmp
                self.pos = _save6
              end
              break
            end # end sequence

            break unless _tmp
          end
          _tmp = true
        else
          self.pos = _save2
        end
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise "   $$ = mk_link(mk_str(yytext), yytext, ""); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_AutoLinkUrl unless _tmp
    return _tmp
  end

  # AutoLinkEmail = "<" < /[-A-Za-z0-9+_]+/ "@" (!Newline !">" .)+ > ">" {  raise ' char *mailto = malloc(strlen(yytext) + 8);                     sprintf(mailto, "mailto:%s", yytext);                     $$ = mk_link(mk_str(yytext), mailto, "");                     free(mailto);'                 }
  def _AutoLinkEmail

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos

      _save1 = self.pos
      while true # sequence
        _tmp = scan(/\A(?-mix:[-A-Za-z0-9+_]+)/)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = match_string("@")
        unless _tmp
          self.pos = _save1
          break
        end
        _save2 = self.pos

        _save3 = self.pos
        while true # sequence
          _save4 = self.pos
          _tmp = apply(:_Newline)
          _tmp = _tmp ? nil : true
          self.pos = _save4
          unless _tmp
            self.pos = _save3
            break
          end
          _save5 = self.pos
          _tmp = match_string(">")
          _tmp = _tmp ? nil : true
          self.pos = _save5
          unless _tmp
            self.pos = _save3
            break
          end
          _tmp = get_byte
          unless _tmp
            self.pos = _save3
          end
          break
        end # end sequence

        if _tmp
          while true

            _save6 = self.pos
            while true # sequence
              _save7 = self.pos
              _tmp = apply(:_Newline)
              _tmp = _tmp ? nil : true
              self.pos = _save7
              unless _tmp
                self.pos = _save6
                break
              end
              _save8 = self.pos
              _tmp = match_string(">")
              _tmp = _tmp ? nil : true
              self.pos = _save8
              unless _tmp
                self.pos = _save6
                break
              end
              _tmp = get_byte
              unless _tmp
                self.pos = _save6
              end
              break
            end # end sequence

            break unless _tmp
          end
          _tmp = true
        else
          self.pos = _save2
        end
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;   raise ' char *mailto = malloc(strlen(yytext) + 8);
                    sprintf(mailto, "mailto:%s", yytext);
                    $$ = mk_link(mk_str(yytext), mailto, "");
                    free(mailto);'
                ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_AutoLinkEmail unless _tmp
    return _tmp
  end

  # Reference = NonindentSpace !"[]" Label:l ":" Spnl RefSrc:s RefTitle:t BlankLine+ { raise ' $$ = mk_link(l->children, s->contents.str, t->contents.str);               free_element(s);               free_element(t);               free(l);               $$->key = REFERENCE; '}
  def _Reference

    _save = self.pos
    while true # sequence
      _tmp = apply(:_NonindentSpace)
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = match_string("[]")
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Label)
      l = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(":")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_RefSrc)
      s = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_RefTitle)
      t = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_BlankLine)
      if _tmp
        while true
          _tmp = apply(:_BlankLine)
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save2
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise ' $$ = mk_link(l->children, s->contents.str, t->contents.str);
              free_element(s);
              free_element(t);
              free(l);
              $$->key = REFERENCE; '; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Reference unless _tmp
    return _tmp
  end

  # Label = "[" (!"^" &{ raise " extension(EXT_NOTES) " } | &. &{ raise "!extension(EXT_NOTES) " }) StartList:a (!"]" Inline { raise " a = cons($$, a); " })* "]" { raise " $$ = mk_list(LIST, a); " }
  def _Label

    _save = self.pos
    while true # sequence
      _tmp = match_string("[")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice

        _save2 = self.pos
        while true # sequence
          _save3 = self.pos
          _tmp = match_string("^")
          _tmp = _tmp ? nil : true
          self.pos = _save3
          unless _tmp
            self.pos = _save2
            break
          end
          _save4 = self.pos
          _tmp = begin;  raise " extension(EXT_NOTES) " ; end
          self.pos = _save4
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save1

        _save5 = self.pos
        while true # sequence
          _save6 = self.pos
          _tmp = get_byte
          self.pos = _save6
          unless _tmp
            self.pos = _save5
            break
          end
          _save7 = self.pos
          _tmp = begin;  raise "!extension(EXT_NOTES) " ; end
          self.pos = _save7
          unless _tmp
            self.pos = _save5
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save9 = self.pos
        while true # sequence
          _save10 = self.pos
          _tmp = match_string("]")
          _tmp = _tmp ? nil : true
          self.pos = _save10
          unless _tmp
            self.pos = _save9
            break
          end
          _tmp = apply(:_Inline)
          unless _tmp
            self.pos = _save9
            break
          end
          @result = begin;  raise " a = cons($$, a); " ; end
          _tmp = true
          unless _tmp
            self.pos = _save9
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("]")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_list(LIST, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Label unless _tmp
    return _tmp
  end

  # RefSrc = < Nonspacechar+ > { raise '$$ = mk_str(yytext);             $$->key = HTML;' }
  def _RefSrc

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _save1 = self.pos
      _tmp = apply(:_Nonspacechar)
      if _tmp
        while true
          _tmp = apply(:_Nonspacechar)
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise '$$ = mk_str(yytext); 
           $$->key = HTML;' ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_RefSrc unless _tmp
    return _tmp
  end

  # RefTitle = (RefTitleSingle | RefTitleDouble | RefTitleParens | EmptyTitle) { raise " $$ = mk_str(yytext); " }
  def _RefTitle

    _save = self.pos
    while true # sequence

      _save1 = self.pos
      while true # choice
        _tmp = apply(:_RefTitleSingle)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_RefTitleDouble)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_RefTitleParens)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_EmptyTitle)
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_str(yytext); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_RefTitle unless _tmp
    return _tmp
  end

  # EmptyTitle = < "" >
  def _EmptyTitle
    _text_start = self.pos
    _tmp = match_string("")
    if _tmp
      text = get_text(_text_start)
    end
    set_failed_rule :_EmptyTitle unless _tmp
    return _tmp
  end

  # RefTitleSingle = Spnl "'" < (!("'" Sp Newline | Newline) .)* > "'"
  def _RefTitleSingle

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("'")
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      while true

        _save2 = self.pos
        while true # sequence
          _save3 = self.pos

          _save4 = self.pos
          while true # choice

            _save5 = self.pos
            while true # sequence
              _tmp = match_string("'")
              unless _tmp
                self.pos = _save5
                break
              end
              _tmp = apply(:_Sp)
              unless _tmp
                self.pos = _save5
                break
              end
              _tmp = apply(:_Newline)
              unless _tmp
                self.pos = _save5
              end
              break
            end # end sequence

            break if _tmp
            self.pos = _save4
            _tmp = apply(:_Newline)
            break if _tmp
            self.pos = _save4
            break
          end # end choice

          _tmp = _tmp ? nil : true
          self.pos = _save3
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = get_byte
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("'")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_RefTitleSingle unless _tmp
    return _tmp
  end

  # RefTitleDouble = Spnl "\"" < (!("\"" Sp Newline | Newline) .)* > "\""
  def _RefTitleDouble

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("\"")
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      while true

        _save2 = self.pos
        while true # sequence
          _save3 = self.pos

          _save4 = self.pos
          while true # choice

            _save5 = self.pos
            while true # sequence
              _tmp = match_string("\"")
              unless _tmp
                self.pos = _save5
                break
              end
              _tmp = apply(:_Sp)
              unless _tmp
                self.pos = _save5
                break
              end
              _tmp = apply(:_Newline)
              unless _tmp
                self.pos = _save5
              end
              break
            end # end sequence

            break if _tmp
            self.pos = _save4
            _tmp = apply(:_Newline)
            break if _tmp
            self.pos = _save4
            break
          end # end choice

          _tmp = _tmp ? nil : true
          self.pos = _save3
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = get_byte
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("\"")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_RefTitleDouble unless _tmp
    return _tmp
  end

  # RefTitleParens = Spnl "(" < (!(")" Sp Newline | Newline) .)* > ")"
  def _RefTitleParens

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("(")
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      while true

        _save2 = self.pos
        while true # sequence
          _save3 = self.pos

          _save4 = self.pos
          while true # choice

            _save5 = self.pos
            while true # sequence
              _tmp = match_string(")")
              unless _tmp
                self.pos = _save5
                break
              end
              _tmp = apply(:_Sp)
              unless _tmp
                self.pos = _save5
                break
              end
              _tmp = apply(:_Newline)
              unless _tmp
                self.pos = _save5
              end
              break
            end # end sequence

            break if _tmp
            self.pos = _save4
            _tmp = apply(:_Newline)
            break if _tmp
            self.pos = _save4
            break
          end # end choice

          _tmp = _tmp ? nil : true
          self.pos = _save3
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = get_byte
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(")")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_RefTitleParens unless _tmp
    return _tmp
  end

  # References = StartList:a (b:reference { raise " a = cons(b, a); " } | SkipBlock)* { raise " references = reverse(a); " }
  def _References

    _save = self.pos
    while true # sequence
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice

          _save3 = self.pos
          while true # sequence
            _tmp = apply(:_b)
            reference = @result
            unless _tmp
              self.pos = _save3
              break
            end
            @result = begin;  raise " a = cons(b, a); " ; end
            _tmp = true
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          _tmp = apply(:_SkipBlock)
          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " references = reverse(a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_References unless _tmp
    return _tmp
  end

  # Ticks1 = "`" !"`"
  def _Ticks1

    _save = self.pos
    while true # sequence
      _tmp = match_string("`")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = match_string("`")
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Ticks1 unless _tmp
    return _tmp
  end

  # Ticks2 = "``" !"`"
  def _Ticks2

    _save = self.pos
    while true # sequence
      _tmp = match_string("``")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = match_string("`")
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Ticks2 unless _tmp
    return _tmp
  end

  # Ticks3 = "```" !"`"
  def _Ticks3

    _save = self.pos
    while true # sequence
      _tmp = match_string("```")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = match_string("`")
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Ticks3 unless _tmp
    return _tmp
  end

  # Ticks4 = "````" !"`"
  def _Ticks4

    _save = self.pos
    while true # sequence
      _tmp = match_string("````")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = match_string("`")
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Ticks4 unless _tmp
    return _tmp
  end

  # Ticks5 = "`````" !"`"
  def _Ticks5

    _save = self.pos
    while true # sequence
      _tmp = match_string("`````")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = match_string("`")
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Ticks5 unless _tmp
    return _tmp
  end

  # Code = (Ticks1 Sp < ((!"`" Nonspacechar)+ | !Ticks1 "`"+ | !(Sp Ticks1) (Spacechar | Newline !BlankLine))+ > Sp Ticks1 | Ticks2 Sp < ((!"`" Nonspacechar)+ | !Ticks2 "`"+ | !(Sp Ticks2) (Spacechar | Newline !BlankLine))+ > Sp Ticks2 | Ticks3 Sp < ((!"`" Nonspacechar)+ | !Ticks3 "`"+ | !(Sp Ticks3) (Spacechar | Newline !BlankLine))+ > Sp Ticks3 | Ticks4 Sp < ((!"`" Nonspacechar)+ | !Ticks4 "`"+ | !(Sp Ticks4) (Spacechar | Newline !BlankLine))+ > Sp Ticks4 | Ticks5 Sp < ((!"`" Nonspacechar)+ | !Ticks5 "`"+ | !(Sp Ticks5) (Spacechar | Newline !BlankLine))+ > Sp Ticks5) { raise " $$ = mk_str(yytext); $$->key = CODE; " }
  def _Code

    _save = self.pos
    while true # sequence

      _save1 = self.pos
      while true # choice

        _save2 = self.pos
        while true # sequence
          _tmp = apply(:_Ticks1)
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save2
            break
          end
          _text_start = self.pos
          _save3 = self.pos

          _save4 = self.pos
          while true # choice
            _save5 = self.pos

            _save6 = self.pos
            while true # sequence
              _save7 = self.pos
              _tmp = match_string("`")
              _tmp = _tmp ? nil : true
              self.pos = _save7
              unless _tmp
                self.pos = _save6
                break
              end
              _tmp = apply(:_Nonspacechar)
              unless _tmp
                self.pos = _save6
              end
              break
            end # end sequence

            if _tmp
              while true

                _save8 = self.pos
                while true # sequence
                  _save9 = self.pos
                  _tmp = match_string("`")
                  _tmp = _tmp ? nil : true
                  self.pos = _save9
                  unless _tmp
                    self.pos = _save8
                    break
                  end
                  _tmp = apply(:_Nonspacechar)
                  unless _tmp
                    self.pos = _save8
                  end
                  break
                end # end sequence

                break unless _tmp
              end
              _tmp = true
            else
              self.pos = _save5
            end
            break if _tmp
            self.pos = _save4

            _save10 = self.pos
            while true # sequence
              _save11 = self.pos
              _tmp = apply(:_Ticks1)
              _tmp = _tmp ? nil : true
              self.pos = _save11
              unless _tmp
                self.pos = _save10
                break
              end
              _save12 = self.pos
              _tmp = match_string("`")
              if _tmp
                while true
                  _tmp = match_string("`")
                  break unless _tmp
                end
                _tmp = true
              else
                self.pos = _save12
              end
              unless _tmp
                self.pos = _save10
              end
              break
            end # end sequence

            break if _tmp
            self.pos = _save4

            _save13 = self.pos
            while true # sequence
              _save14 = self.pos

              _save15 = self.pos
              while true # sequence
                _tmp = apply(:_Sp)
                unless _tmp
                  self.pos = _save15
                  break
                end
                _tmp = apply(:_Ticks1)
                unless _tmp
                  self.pos = _save15
                end
                break
              end # end sequence

              _tmp = _tmp ? nil : true
              self.pos = _save14
              unless _tmp
                self.pos = _save13
                break
              end

              _save16 = self.pos
              while true # choice
                _tmp = apply(:_Spacechar)
                break if _tmp
                self.pos = _save16

                _save17 = self.pos
                while true # sequence
                  _tmp = apply(:_Newline)
                  unless _tmp
                    self.pos = _save17
                    break
                  end
                  _save18 = self.pos
                  _tmp = apply(:_BlankLine)
                  _tmp = _tmp ? nil : true
                  self.pos = _save18
                  unless _tmp
                    self.pos = _save17
                  end
                  break
                end # end sequence

                break if _tmp
                self.pos = _save16
                break
              end # end choice

              unless _tmp
                self.pos = _save13
              end
              break
            end # end sequence

            break if _tmp
            self.pos = _save4
            break
          end # end choice

          if _tmp
            while true

              _save19 = self.pos
              while true # choice
                _save20 = self.pos

                _save21 = self.pos
                while true # sequence
                  _save22 = self.pos
                  _tmp = match_string("`")
                  _tmp = _tmp ? nil : true
                  self.pos = _save22
                  unless _tmp
                    self.pos = _save21
                    break
                  end
                  _tmp = apply(:_Nonspacechar)
                  unless _tmp
                    self.pos = _save21
                  end
                  break
                end # end sequence

                if _tmp
                  while true

                    _save23 = self.pos
                    while true # sequence
                      _save24 = self.pos
                      _tmp = match_string("`")
                      _tmp = _tmp ? nil : true
                      self.pos = _save24
                      unless _tmp
                        self.pos = _save23
                        break
                      end
                      _tmp = apply(:_Nonspacechar)
                      unless _tmp
                        self.pos = _save23
                      end
                      break
                    end # end sequence

                    break unless _tmp
                  end
                  _tmp = true
                else
                  self.pos = _save20
                end
                break if _tmp
                self.pos = _save19

                _save25 = self.pos
                while true # sequence
                  _save26 = self.pos
                  _tmp = apply(:_Ticks1)
                  _tmp = _tmp ? nil : true
                  self.pos = _save26
                  unless _tmp
                    self.pos = _save25
                    break
                  end
                  _save27 = self.pos
                  _tmp = match_string("`")
                  if _tmp
                    while true
                      _tmp = match_string("`")
                      break unless _tmp
                    end
                    _tmp = true
                  else
                    self.pos = _save27
                  end
                  unless _tmp
                    self.pos = _save25
                  end
                  break
                end # end sequence

                break if _tmp
                self.pos = _save19

                _save28 = self.pos
                while true # sequence
                  _save29 = self.pos

                  _save30 = self.pos
                  while true # sequence
                    _tmp = apply(:_Sp)
                    unless _tmp
                      self.pos = _save30
                      break
                    end
                    _tmp = apply(:_Ticks1)
                    unless _tmp
                      self.pos = _save30
                    end
                    break
                  end # end sequence

                  _tmp = _tmp ? nil : true
                  self.pos = _save29
                  unless _tmp
                    self.pos = _save28
                    break
                  end

                  _save31 = self.pos
                  while true # choice
                    _tmp = apply(:_Spacechar)
                    break if _tmp
                    self.pos = _save31

                    _save32 = self.pos
                    while true # sequence
                      _tmp = apply(:_Newline)
                      unless _tmp
                        self.pos = _save32
                        break
                      end
                      _save33 = self.pos
                      _tmp = apply(:_BlankLine)
                      _tmp = _tmp ? nil : true
                      self.pos = _save33
                      unless _tmp
                        self.pos = _save32
                      end
                      break
                    end # end sequence

                    break if _tmp
                    self.pos = _save31
                    break
                  end # end choice

                  unless _tmp
                    self.pos = _save28
                  end
                  break
                end # end sequence

                break if _tmp
                self.pos = _save19
                break
              end # end choice

              break unless _tmp
            end
            _tmp = true
          else
            self.pos = _save3
          end
          if _tmp
            text = get_text(_text_start)
          end
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = apply(:_Ticks1)
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save1

        _save34 = self.pos
        while true # sequence
          _tmp = apply(:_Ticks2)
          unless _tmp
            self.pos = _save34
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save34
            break
          end
          _text_start = self.pos
          _save35 = self.pos

          _save36 = self.pos
          while true # choice
            _save37 = self.pos

            _save38 = self.pos
            while true # sequence
              _save39 = self.pos
              _tmp = match_string("`")
              _tmp = _tmp ? nil : true
              self.pos = _save39
              unless _tmp
                self.pos = _save38
                break
              end
              _tmp = apply(:_Nonspacechar)
              unless _tmp
                self.pos = _save38
              end
              break
            end # end sequence

            if _tmp
              while true

                _save40 = self.pos
                while true # sequence
                  _save41 = self.pos
                  _tmp = match_string("`")
                  _tmp = _tmp ? nil : true
                  self.pos = _save41
                  unless _tmp
                    self.pos = _save40
                    break
                  end
                  _tmp = apply(:_Nonspacechar)
                  unless _tmp
                    self.pos = _save40
                  end
                  break
                end # end sequence

                break unless _tmp
              end
              _tmp = true
            else
              self.pos = _save37
            end
            break if _tmp
            self.pos = _save36

            _save42 = self.pos
            while true # sequence
              _save43 = self.pos
              _tmp = apply(:_Ticks2)
              _tmp = _tmp ? nil : true
              self.pos = _save43
              unless _tmp
                self.pos = _save42
                break
              end
              _save44 = self.pos
              _tmp = match_string("`")
              if _tmp
                while true
                  _tmp = match_string("`")
                  break unless _tmp
                end
                _tmp = true
              else
                self.pos = _save44
              end
              unless _tmp
                self.pos = _save42
              end
              break
            end # end sequence

            break if _tmp
            self.pos = _save36

            _save45 = self.pos
            while true # sequence
              _save46 = self.pos

              _save47 = self.pos
              while true # sequence
                _tmp = apply(:_Sp)
                unless _tmp
                  self.pos = _save47
                  break
                end
                _tmp = apply(:_Ticks2)
                unless _tmp
                  self.pos = _save47
                end
                break
              end # end sequence

              _tmp = _tmp ? nil : true
              self.pos = _save46
              unless _tmp
                self.pos = _save45
                break
              end

              _save48 = self.pos
              while true # choice
                _tmp = apply(:_Spacechar)
                break if _tmp
                self.pos = _save48

                _save49 = self.pos
                while true # sequence
                  _tmp = apply(:_Newline)
                  unless _tmp
                    self.pos = _save49
                    break
                  end
                  _save50 = self.pos
                  _tmp = apply(:_BlankLine)
                  _tmp = _tmp ? nil : true
                  self.pos = _save50
                  unless _tmp
                    self.pos = _save49
                  end
                  break
                end # end sequence

                break if _tmp
                self.pos = _save48
                break
              end # end choice

              unless _tmp
                self.pos = _save45
              end
              break
            end # end sequence

            break if _tmp
            self.pos = _save36
            break
          end # end choice

          if _tmp
            while true

              _save51 = self.pos
              while true # choice
                _save52 = self.pos

                _save53 = self.pos
                while true # sequence
                  _save54 = self.pos
                  _tmp = match_string("`")
                  _tmp = _tmp ? nil : true
                  self.pos = _save54
                  unless _tmp
                    self.pos = _save53
                    break
                  end
                  _tmp = apply(:_Nonspacechar)
                  unless _tmp
                    self.pos = _save53
                  end
                  break
                end # end sequence

                if _tmp
                  while true

                    _save55 = self.pos
                    while true # sequence
                      _save56 = self.pos
                      _tmp = match_string("`")
                      _tmp = _tmp ? nil : true
                      self.pos = _save56
                      unless _tmp
                        self.pos = _save55
                        break
                      end
                      _tmp = apply(:_Nonspacechar)
                      unless _tmp
                        self.pos = _save55
                      end
                      break
                    end # end sequence

                    break unless _tmp
                  end
                  _tmp = true
                else
                  self.pos = _save52
                end
                break if _tmp
                self.pos = _save51

                _save57 = self.pos
                while true # sequence
                  _save58 = self.pos
                  _tmp = apply(:_Ticks2)
                  _tmp = _tmp ? nil : true
                  self.pos = _save58
                  unless _tmp
                    self.pos = _save57
                    break
                  end
                  _save59 = self.pos
                  _tmp = match_string("`")
                  if _tmp
                    while true
                      _tmp = match_string("`")
                      break unless _tmp
                    end
                    _tmp = true
                  else
                    self.pos = _save59
                  end
                  unless _tmp
                    self.pos = _save57
                  end
                  break
                end # end sequence

                break if _tmp
                self.pos = _save51

                _save60 = self.pos
                while true # sequence
                  _save61 = self.pos

                  _save62 = self.pos
                  while true # sequence
                    _tmp = apply(:_Sp)
                    unless _tmp
                      self.pos = _save62
                      break
                    end
                    _tmp = apply(:_Ticks2)
                    unless _tmp
                      self.pos = _save62
                    end
                    break
                  end # end sequence

                  _tmp = _tmp ? nil : true
                  self.pos = _save61
                  unless _tmp
                    self.pos = _save60
                    break
                  end

                  _save63 = self.pos
                  while true # choice
                    _tmp = apply(:_Spacechar)
                    break if _tmp
                    self.pos = _save63

                    _save64 = self.pos
                    while true # sequence
                      _tmp = apply(:_Newline)
                      unless _tmp
                        self.pos = _save64
                        break
                      end
                      _save65 = self.pos
                      _tmp = apply(:_BlankLine)
                      _tmp = _tmp ? nil : true
                      self.pos = _save65
                      unless _tmp
                        self.pos = _save64
                      end
                      break
                    end # end sequence

                    break if _tmp
                    self.pos = _save63
                    break
                  end # end choice

                  unless _tmp
                    self.pos = _save60
                  end
                  break
                end # end sequence

                break if _tmp
                self.pos = _save51
                break
              end # end choice

              break unless _tmp
            end
            _tmp = true
          else
            self.pos = _save35
          end
          if _tmp
            text = get_text(_text_start)
          end
          unless _tmp
            self.pos = _save34
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save34
            break
          end
          _tmp = apply(:_Ticks2)
          unless _tmp
            self.pos = _save34
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save1

        _save66 = self.pos
        while true # sequence
          _tmp = apply(:_Ticks3)
          unless _tmp
            self.pos = _save66
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save66
            break
          end
          _text_start = self.pos
          _save67 = self.pos

          _save68 = self.pos
          while true # choice
            _save69 = self.pos

            _save70 = self.pos
            while true # sequence
              _save71 = self.pos
              _tmp = match_string("`")
              _tmp = _tmp ? nil : true
              self.pos = _save71
              unless _tmp
                self.pos = _save70
                break
              end
              _tmp = apply(:_Nonspacechar)
              unless _tmp
                self.pos = _save70
              end
              break
            end # end sequence

            if _tmp
              while true

                _save72 = self.pos
                while true # sequence
                  _save73 = self.pos
                  _tmp = match_string("`")
                  _tmp = _tmp ? nil : true
                  self.pos = _save73
                  unless _tmp
                    self.pos = _save72
                    break
                  end
                  _tmp = apply(:_Nonspacechar)
                  unless _tmp
                    self.pos = _save72
                  end
                  break
                end # end sequence

                break unless _tmp
              end
              _tmp = true
            else
              self.pos = _save69
            end
            break if _tmp
            self.pos = _save68

            _save74 = self.pos
            while true # sequence
              _save75 = self.pos
              _tmp = apply(:_Ticks3)
              _tmp = _tmp ? nil : true
              self.pos = _save75
              unless _tmp
                self.pos = _save74
                break
              end
              _save76 = self.pos
              _tmp = match_string("`")
              if _tmp
                while true
                  _tmp = match_string("`")
                  break unless _tmp
                end
                _tmp = true
              else
                self.pos = _save76
              end
              unless _tmp
                self.pos = _save74
              end
              break
            end # end sequence

            break if _tmp
            self.pos = _save68

            _save77 = self.pos
            while true # sequence
              _save78 = self.pos

              _save79 = self.pos
              while true # sequence
                _tmp = apply(:_Sp)
                unless _tmp
                  self.pos = _save79
                  break
                end
                _tmp = apply(:_Ticks3)
                unless _tmp
                  self.pos = _save79
                end
                break
              end # end sequence

              _tmp = _tmp ? nil : true
              self.pos = _save78
              unless _tmp
                self.pos = _save77
                break
              end

              _save80 = self.pos
              while true # choice
                _tmp = apply(:_Spacechar)
                break if _tmp
                self.pos = _save80

                _save81 = self.pos
                while true # sequence
                  _tmp = apply(:_Newline)
                  unless _tmp
                    self.pos = _save81
                    break
                  end
                  _save82 = self.pos
                  _tmp = apply(:_BlankLine)
                  _tmp = _tmp ? nil : true
                  self.pos = _save82
                  unless _tmp
                    self.pos = _save81
                  end
                  break
                end # end sequence

                break if _tmp
                self.pos = _save80
                break
              end # end choice

              unless _tmp
                self.pos = _save77
              end
              break
            end # end sequence

            break if _tmp
            self.pos = _save68
            break
          end # end choice

          if _tmp
            while true

              _save83 = self.pos
              while true # choice
                _save84 = self.pos

                _save85 = self.pos
                while true # sequence
                  _save86 = self.pos
                  _tmp = match_string("`")
                  _tmp = _tmp ? nil : true
                  self.pos = _save86
                  unless _tmp
                    self.pos = _save85
                    break
                  end
                  _tmp = apply(:_Nonspacechar)
                  unless _tmp
                    self.pos = _save85
                  end
                  break
                end # end sequence

                if _tmp
                  while true

                    _save87 = self.pos
                    while true # sequence
                      _save88 = self.pos
                      _tmp = match_string("`")
                      _tmp = _tmp ? nil : true
                      self.pos = _save88
                      unless _tmp
                        self.pos = _save87
                        break
                      end
                      _tmp = apply(:_Nonspacechar)
                      unless _tmp
                        self.pos = _save87
                      end
                      break
                    end # end sequence

                    break unless _tmp
                  end
                  _tmp = true
                else
                  self.pos = _save84
                end
                break if _tmp
                self.pos = _save83

                _save89 = self.pos
                while true # sequence
                  _save90 = self.pos
                  _tmp = apply(:_Ticks3)
                  _tmp = _tmp ? nil : true
                  self.pos = _save90
                  unless _tmp
                    self.pos = _save89
                    break
                  end
                  _save91 = self.pos
                  _tmp = match_string("`")
                  if _tmp
                    while true
                      _tmp = match_string("`")
                      break unless _tmp
                    end
                    _tmp = true
                  else
                    self.pos = _save91
                  end
                  unless _tmp
                    self.pos = _save89
                  end
                  break
                end # end sequence

                break if _tmp
                self.pos = _save83

                _save92 = self.pos
                while true # sequence
                  _save93 = self.pos

                  _save94 = self.pos
                  while true # sequence
                    _tmp = apply(:_Sp)
                    unless _tmp
                      self.pos = _save94
                      break
                    end
                    _tmp = apply(:_Ticks3)
                    unless _tmp
                      self.pos = _save94
                    end
                    break
                  end # end sequence

                  _tmp = _tmp ? nil : true
                  self.pos = _save93
                  unless _tmp
                    self.pos = _save92
                    break
                  end

                  _save95 = self.pos
                  while true # choice
                    _tmp = apply(:_Spacechar)
                    break if _tmp
                    self.pos = _save95

                    _save96 = self.pos
                    while true # sequence
                      _tmp = apply(:_Newline)
                      unless _tmp
                        self.pos = _save96
                        break
                      end
                      _save97 = self.pos
                      _tmp = apply(:_BlankLine)
                      _tmp = _tmp ? nil : true
                      self.pos = _save97
                      unless _tmp
                        self.pos = _save96
                      end
                      break
                    end # end sequence

                    break if _tmp
                    self.pos = _save95
                    break
                  end # end choice

                  unless _tmp
                    self.pos = _save92
                  end
                  break
                end # end sequence

                break if _tmp
                self.pos = _save83
                break
              end # end choice

              break unless _tmp
            end
            _tmp = true
          else
            self.pos = _save67
          end
          if _tmp
            text = get_text(_text_start)
          end
          unless _tmp
            self.pos = _save66
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save66
            break
          end
          _tmp = apply(:_Ticks3)
          unless _tmp
            self.pos = _save66
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save1

        _save98 = self.pos
        while true # sequence
          _tmp = apply(:_Ticks4)
          unless _tmp
            self.pos = _save98
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save98
            break
          end
          _text_start = self.pos
          _save99 = self.pos

          _save100 = self.pos
          while true # choice
            _save101 = self.pos

            _save102 = self.pos
            while true # sequence
              _save103 = self.pos
              _tmp = match_string("`")
              _tmp = _tmp ? nil : true
              self.pos = _save103
              unless _tmp
                self.pos = _save102
                break
              end
              _tmp = apply(:_Nonspacechar)
              unless _tmp
                self.pos = _save102
              end
              break
            end # end sequence

            if _tmp
              while true

                _save104 = self.pos
                while true # sequence
                  _save105 = self.pos
                  _tmp = match_string("`")
                  _tmp = _tmp ? nil : true
                  self.pos = _save105
                  unless _tmp
                    self.pos = _save104
                    break
                  end
                  _tmp = apply(:_Nonspacechar)
                  unless _tmp
                    self.pos = _save104
                  end
                  break
                end # end sequence

                break unless _tmp
              end
              _tmp = true
            else
              self.pos = _save101
            end
            break if _tmp
            self.pos = _save100

            _save106 = self.pos
            while true # sequence
              _save107 = self.pos
              _tmp = apply(:_Ticks4)
              _tmp = _tmp ? nil : true
              self.pos = _save107
              unless _tmp
                self.pos = _save106
                break
              end
              _save108 = self.pos
              _tmp = match_string("`")
              if _tmp
                while true
                  _tmp = match_string("`")
                  break unless _tmp
                end
                _tmp = true
              else
                self.pos = _save108
              end
              unless _tmp
                self.pos = _save106
              end
              break
            end # end sequence

            break if _tmp
            self.pos = _save100

            _save109 = self.pos
            while true # sequence
              _save110 = self.pos

              _save111 = self.pos
              while true # sequence
                _tmp = apply(:_Sp)
                unless _tmp
                  self.pos = _save111
                  break
                end
                _tmp = apply(:_Ticks4)
                unless _tmp
                  self.pos = _save111
                end
                break
              end # end sequence

              _tmp = _tmp ? nil : true
              self.pos = _save110
              unless _tmp
                self.pos = _save109
                break
              end

              _save112 = self.pos
              while true # choice
                _tmp = apply(:_Spacechar)
                break if _tmp
                self.pos = _save112

                _save113 = self.pos
                while true # sequence
                  _tmp = apply(:_Newline)
                  unless _tmp
                    self.pos = _save113
                    break
                  end
                  _save114 = self.pos
                  _tmp = apply(:_BlankLine)
                  _tmp = _tmp ? nil : true
                  self.pos = _save114
                  unless _tmp
                    self.pos = _save113
                  end
                  break
                end # end sequence

                break if _tmp
                self.pos = _save112
                break
              end # end choice

              unless _tmp
                self.pos = _save109
              end
              break
            end # end sequence

            break if _tmp
            self.pos = _save100
            break
          end # end choice

          if _tmp
            while true

              _save115 = self.pos
              while true # choice
                _save116 = self.pos

                _save117 = self.pos
                while true # sequence
                  _save118 = self.pos
                  _tmp = match_string("`")
                  _tmp = _tmp ? nil : true
                  self.pos = _save118
                  unless _tmp
                    self.pos = _save117
                    break
                  end
                  _tmp = apply(:_Nonspacechar)
                  unless _tmp
                    self.pos = _save117
                  end
                  break
                end # end sequence

                if _tmp
                  while true

                    _save119 = self.pos
                    while true # sequence
                      _save120 = self.pos
                      _tmp = match_string("`")
                      _tmp = _tmp ? nil : true
                      self.pos = _save120
                      unless _tmp
                        self.pos = _save119
                        break
                      end
                      _tmp = apply(:_Nonspacechar)
                      unless _tmp
                        self.pos = _save119
                      end
                      break
                    end # end sequence

                    break unless _tmp
                  end
                  _tmp = true
                else
                  self.pos = _save116
                end
                break if _tmp
                self.pos = _save115

                _save121 = self.pos
                while true # sequence
                  _save122 = self.pos
                  _tmp = apply(:_Ticks4)
                  _tmp = _tmp ? nil : true
                  self.pos = _save122
                  unless _tmp
                    self.pos = _save121
                    break
                  end
                  _save123 = self.pos
                  _tmp = match_string("`")
                  if _tmp
                    while true
                      _tmp = match_string("`")
                      break unless _tmp
                    end
                    _tmp = true
                  else
                    self.pos = _save123
                  end
                  unless _tmp
                    self.pos = _save121
                  end
                  break
                end # end sequence

                break if _tmp
                self.pos = _save115

                _save124 = self.pos
                while true # sequence
                  _save125 = self.pos

                  _save126 = self.pos
                  while true # sequence
                    _tmp = apply(:_Sp)
                    unless _tmp
                      self.pos = _save126
                      break
                    end
                    _tmp = apply(:_Ticks4)
                    unless _tmp
                      self.pos = _save126
                    end
                    break
                  end # end sequence

                  _tmp = _tmp ? nil : true
                  self.pos = _save125
                  unless _tmp
                    self.pos = _save124
                    break
                  end

                  _save127 = self.pos
                  while true # choice
                    _tmp = apply(:_Spacechar)
                    break if _tmp
                    self.pos = _save127

                    _save128 = self.pos
                    while true # sequence
                      _tmp = apply(:_Newline)
                      unless _tmp
                        self.pos = _save128
                        break
                      end
                      _save129 = self.pos
                      _tmp = apply(:_BlankLine)
                      _tmp = _tmp ? nil : true
                      self.pos = _save129
                      unless _tmp
                        self.pos = _save128
                      end
                      break
                    end # end sequence

                    break if _tmp
                    self.pos = _save127
                    break
                  end # end choice

                  unless _tmp
                    self.pos = _save124
                  end
                  break
                end # end sequence

                break if _tmp
                self.pos = _save115
                break
              end # end choice

              break unless _tmp
            end
            _tmp = true
          else
            self.pos = _save99
          end
          if _tmp
            text = get_text(_text_start)
          end
          unless _tmp
            self.pos = _save98
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save98
            break
          end
          _tmp = apply(:_Ticks4)
          unless _tmp
            self.pos = _save98
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save1

        _save130 = self.pos
        while true # sequence
          _tmp = apply(:_Ticks5)
          unless _tmp
            self.pos = _save130
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save130
            break
          end
          _text_start = self.pos
          _save131 = self.pos

          _save132 = self.pos
          while true # choice
            _save133 = self.pos

            _save134 = self.pos
            while true # sequence
              _save135 = self.pos
              _tmp = match_string("`")
              _tmp = _tmp ? nil : true
              self.pos = _save135
              unless _tmp
                self.pos = _save134
                break
              end
              _tmp = apply(:_Nonspacechar)
              unless _tmp
                self.pos = _save134
              end
              break
            end # end sequence

            if _tmp
              while true

                _save136 = self.pos
                while true # sequence
                  _save137 = self.pos
                  _tmp = match_string("`")
                  _tmp = _tmp ? nil : true
                  self.pos = _save137
                  unless _tmp
                    self.pos = _save136
                    break
                  end
                  _tmp = apply(:_Nonspacechar)
                  unless _tmp
                    self.pos = _save136
                  end
                  break
                end # end sequence

                break unless _tmp
              end
              _tmp = true
            else
              self.pos = _save133
            end
            break if _tmp
            self.pos = _save132

            _save138 = self.pos
            while true # sequence
              _save139 = self.pos
              _tmp = apply(:_Ticks5)
              _tmp = _tmp ? nil : true
              self.pos = _save139
              unless _tmp
                self.pos = _save138
                break
              end
              _save140 = self.pos
              _tmp = match_string("`")
              if _tmp
                while true
                  _tmp = match_string("`")
                  break unless _tmp
                end
                _tmp = true
              else
                self.pos = _save140
              end
              unless _tmp
                self.pos = _save138
              end
              break
            end # end sequence

            break if _tmp
            self.pos = _save132

            _save141 = self.pos
            while true # sequence
              _save142 = self.pos

              _save143 = self.pos
              while true # sequence
                _tmp = apply(:_Sp)
                unless _tmp
                  self.pos = _save143
                  break
                end
                _tmp = apply(:_Ticks5)
                unless _tmp
                  self.pos = _save143
                end
                break
              end # end sequence

              _tmp = _tmp ? nil : true
              self.pos = _save142
              unless _tmp
                self.pos = _save141
                break
              end

              _save144 = self.pos
              while true # choice
                _tmp = apply(:_Spacechar)
                break if _tmp
                self.pos = _save144

                _save145 = self.pos
                while true # sequence
                  _tmp = apply(:_Newline)
                  unless _tmp
                    self.pos = _save145
                    break
                  end
                  _save146 = self.pos
                  _tmp = apply(:_BlankLine)
                  _tmp = _tmp ? nil : true
                  self.pos = _save146
                  unless _tmp
                    self.pos = _save145
                  end
                  break
                end # end sequence

                break if _tmp
                self.pos = _save144
                break
              end # end choice

              unless _tmp
                self.pos = _save141
              end
              break
            end # end sequence

            break if _tmp
            self.pos = _save132
            break
          end # end choice

          if _tmp
            while true

              _save147 = self.pos
              while true # choice
                _save148 = self.pos

                _save149 = self.pos
                while true # sequence
                  _save150 = self.pos
                  _tmp = match_string("`")
                  _tmp = _tmp ? nil : true
                  self.pos = _save150
                  unless _tmp
                    self.pos = _save149
                    break
                  end
                  _tmp = apply(:_Nonspacechar)
                  unless _tmp
                    self.pos = _save149
                  end
                  break
                end # end sequence

                if _tmp
                  while true

                    _save151 = self.pos
                    while true # sequence
                      _save152 = self.pos
                      _tmp = match_string("`")
                      _tmp = _tmp ? nil : true
                      self.pos = _save152
                      unless _tmp
                        self.pos = _save151
                        break
                      end
                      _tmp = apply(:_Nonspacechar)
                      unless _tmp
                        self.pos = _save151
                      end
                      break
                    end # end sequence

                    break unless _tmp
                  end
                  _tmp = true
                else
                  self.pos = _save148
                end
                break if _tmp
                self.pos = _save147

                _save153 = self.pos
                while true # sequence
                  _save154 = self.pos
                  _tmp = apply(:_Ticks5)
                  _tmp = _tmp ? nil : true
                  self.pos = _save154
                  unless _tmp
                    self.pos = _save153
                    break
                  end
                  _save155 = self.pos
                  _tmp = match_string("`")
                  if _tmp
                    while true
                      _tmp = match_string("`")
                      break unless _tmp
                    end
                    _tmp = true
                  else
                    self.pos = _save155
                  end
                  unless _tmp
                    self.pos = _save153
                  end
                  break
                end # end sequence

                break if _tmp
                self.pos = _save147

                _save156 = self.pos
                while true # sequence
                  _save157 = self.pos

                  _save158 = self.pos
                  while true # sequence
                    _tmp = apply(:_Sp)
                    unless _tmp
                      self.pos = _save158
                      break
                    end
                    _tmp = apply(:_Ticks5)
                    unless _tmp
                      self.pos = _save158
                    end
                    break
                  end # end sequence

                  _tmp = _tmp ? nil : true
                  self.pos = _save157
                  unless _tmp
                    self.pos = _save156
                    break
                  end

                  _save159 = self.pos
                  while true # choice
                    _tmp = apply(:_Spacechar)
                    break if _tmp
                    self.pos = _save159

                    _save160 = self.pos
                    while true # sequence
                      _tmp = apply(:_Newline)
                      unless _tmp
                        self.pos = _save160
                        break
                      end
                      _save161 = self.pos
                      _tmp = apply(:_BlankLine)
                      _tmp = _tmp ? nil : true
                      self.pos = _save161
                      unless _tmp
                        self.pos = _save160
                      end
                      break
                    end # end sequence

                    break if _tmp
                    self.pos = _save159
                    break
                  end # end choice

                  unless _tmp
                    self.pos = _save156
                  end
                  break
                end # end sequence

                break if _tmp
                self.pos = _save147
                break
              end # end choice

              break unless _tmp
            end
            _tmp = true
          else
            self.pos = _save131
          end
          if _tmp
            text = get_text(_text_start)
          end
          unless _tmp
            self.pos = _save130
            break
          end
          _tmp = apply(:_Sp)
          unless _tmp
            self.pos = _save130
            break
          end
          _tmp = apply(:_Ticks5)
          unless _tmp
            self.pos = _save130
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_str(yytext); $$->key = CODE; " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Code unless _tmp
    return _tmp
  end

  # RawHtml = < (HtmlComment | HtmlBlockScript | HtmlTag) > {   raise 'if (extension(EXT_FILTER_HTML)) {                     $$ = mk_list(LIST, NULL);                 } else {                     $$ = mk_str(yytext);                     $$->key = HTML;                 }'             }
  def _RawHtml

    _save = self.pos
    while true # sequence
      _text_start = self.pos

      _save1 = self.pos
      while true # choice
        _tmp = apply(:_HtmlComment)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_HtmlBlockScript)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_HtmlTag)
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;    raise 'if (extension(EXT_FILTER_HTML)) {
                    $$ = mk_list(LIST, NULL);
                } else {
                    $$ = mk_str(yytext);
                    $$->key = HTML;
                }'
            ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_RawHtml unless _tmp
    return _tmp
  end

  # BlankLine = Sp Newline
  def _BlankLine

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Newline)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_BlankLine unless _tmp
    return _tmp
  end

  # Quoted = ("\"" (!"\"" .)* "\"" | "'" (!"'" .)* "'")
  def _Quoted

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = match_string("\"")
        unless _tmp
          self.pos = _save1
          break
        end
        while true

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = match_string("\"")
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = match_string("\"")
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save5 = self.pos
      while true # sequence
        _tmp = match_string("'")
        unless _tmp
          self.pos = _save5
          break
        end
        while true

          _save7 = self.pos
          while true # sequence
            _save8 = self.pos
            _tmp = match_string("'")
            _tmp = _tmp ? nil : true
            self.pos = _save8
            unless _tmp
              self.pos = _save7
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save7
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
        unless _tmp
          self.pos = _save5
          break
        end
        _tmp = match_string("'")
        unless _tmp
          self.pos = _save5
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_Quoted unless _tmp
    return _tmp
  end

  # HtmlAttribute = (AlphanumericAscii | "-")+ Spnl ("=" Spnl (Quoted | (!">" Nonspacechar)+))? Spnl
  def _HtmlAttribute

    _save = self.pos
    while true # sequence
      _save1 = self.pos

      _save2 = self.pos
      while true # choice
        _tmp = apply(:_AlphanumericAscii)
        break if _tmp
        self.pos = _save2
        _tmp = match_string("-")
        break if _tmp
        self.pos = _save2
        break
      end # end choice

      if _tmp
        while true

          _save3 = self.pos
          while true # choice
            _tmp = apply(:_AlphanumericAscii)
            break if _tmp
            self.pos = _save3
            _tmp = match_string("-")
            break if _tmp
            self.pos = _save3
            break
          end # end choice

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _save4 = self.pos

      _save5 = self.pos
      while true # sequence
        _tmp = match_string("=")
        unless _tmp
          self.pos = _save5
          break
        end
        _tmp = apply(:_Spnl)
        unless _tmp
          self.pos = _save5
          break
        end

        _save6 = self.pos
        while true # choice
          _tmp = apply(:_Quoted)
          break if _tmp
          self.pos = _save6
          _save7 = self.pos

          _save8 = self.pos
          while true # sequence
            _save9 = self.pos
            _tmp = match_string(">")
            _tmp = _tmp ? nil : true
            self.pos = _save9
            unless _tmp
              self.pos = _save8
              break
            end
            _tmp = apply(:_Nonspacechar)
            unless _tmp
              self.pos = _save8
            end
            break
          end # end sequence

          if _tmp
            while true

              _save10 = self.pos
              while true # sequence
                _save11 = self.pos
                _tmp = match_string(">")
                _tmp = _tmp ? nil : true
                self.pos = _save11
                unless _tmp
                  self.pos = _save10
                  break
                end
                _tmp = apply(:_Nonspacechar)
                unless _tmp
                  self.pos = _save10
                end
                break
              end # end sequence

              break unless _tmp
            end
            _tmp = true
          else
            self.pos = _save7
          end
          break if _tmp
          self.pos = _save6
          break
        end # end choice

        unless _tmp
          self.pos = _save5
        end
        break
      end # end sequence

      unless _tmp
        _tmp = true
        self.pos = _save4
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlAttribute unless _tmp
    return _tmp
  end

  # HtmlComment = "<!--" (!"-->" .)* "-->"
  def _HtmlComment

    _save = self.pos
    while true # sequence
      _tmp = match_string("<!--")
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # sequence
          _save3 = self.pos
          _tmp = match_string("-->")
          _tmp = _tmp ? nil : true
          self.pos = _save3
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = get_byte
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("-->")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlComment unless _tmp
    return _tmp
  end

  # HtmlTag = "<" Spnl "/"? AlphanumericAscii+ Spnl HtmlAttribute* "/"? Spnl ">"
  def _HtmlTag

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = match_string("/")
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_AlphanumericAscii)
      if _tmp
        while true
          _tmp = apply(:_AlphanumericAscii)
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save2
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_HtmlAttribute)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _save4 = self.pos
      _tmp = match_string("/")
      unless _tmp
        _tmp = true
        self.pos = _save4
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Spnl)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(">")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_HtmlTag unless _tmp
    return _tmp
  end

  # Eof = !.
  def _Eof
    _save = self.pos
    _tmp = get_byte
    _tmp = _tmp ? nil : true
    self.pos = _save
    set_failed_rule :_Eof unless _tmp
    return _tmp
  end

  # Spacechar = (" " | "\t")
  def _Spacechar

    _save = self.pos
    while true # choice
      _tmp = match_string(" ")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\t")
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_Spacechar unless _tmp
    return _tmp
  end

  # Nonspacechar = !Spacechar !Newline .
  def _Nonspacechar

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_Spacechar)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_Newline)
      _tmp = _tmp ? nil : true
      self.pos = _save2
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = get_byte
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Nonspacechar unless _tmp
    return _tmp
  end

  # Newline = ("\n" | "" "\n"?)
  def _Newline

    _save = self.pos
    while true # choice
      _tmp = match_string("\n")
      break if _tmp
      self.pos = _save

      _save1 = self.pos
      while true # sequence
        _tmp = match_string("\r")
        unless _tmp
          self.pos = _save1
          break
        end
        _save2 = self.pos
        _tmp = match_string("\n")
        unless _tmp
          _tmp = true
          self.pos = _save2
        end
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_Newline unless _tmp
    return _tmp
  end

  # Sp = Spacechar*
  def _Sp
    while true
      _tmp = apply(:_Spacechar)
      break unless _tmp
    end
    _tmp = true
    set_failed_rule :_Sp unless _tmp
    return _tmp
  end

  # Spnl = Sp (Newline Sp)?
  def _Spnl

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _tmp = apply(:_Newline)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_Sp)
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Spnl unless _tmp
    return _tmp
  end

  # SpecialChar = ("*" | "_" | "`" | "&" | "[" | "]" | "(" | ")" | "<" | "!" | "#" | "\\" | "'" | "\"" | ExtendedSpecialChar)
  def _SpecialChar

    _save = self.pos
    while true # choice
      _tmp = match_string("*")
      break if _tmp
      self.pos = _save
      _tmp = match_string("_")
      break if _tmp
      self.pos = _save
      _tmp = match_string("`")
      break if _tmp
      self.pos = _save
      _tmp = match_string("&")
      break if _tmp
      self.pos = _save
      _tmp = match_string("[")
      break if _tmp
      self.pos = _save
      _tmp = match_string("]")
      break if _tmp
      self.pos = _save
      _tmp = match_string("(")
      break if _tmp
      self.pos = _save
      _tmp = match_string(")")
      break if _tmp
      self.pos = _save
      _tmp = match_string("<")
      break if _tmp
      self.pos = _save
      _tmp = match_string("!")
      break if _tmp
      self.pos = _save
      _tmp = match_string("#")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\\")
      break if _tmp
      self.pos = _save
      _tmp = match_string("'")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\"")
      break if _tmp
      self.pos = _save
      _tmp = apply(:_ExtendedSpecialChar)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_SpecialChar unless _tmp
    return _tmp
  end

  # NormalChar = !(SpecialChar | Spacechar | Newline) .
  def _NormalChar

    _save = self.pos
    while true # sequence
      _save1 = self.pos

      _save2 = self.pos
      while true # choice
        _tmp = apply(:_SpecialChar)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_Spacechar)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_Newline)
        break if _tmp
        self.pos = _save2
        break
      end # end choice

      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = get_byte
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_NormalChar unless _tmp
    return _tmp
  end

  # NonAlphanumeric = /[\000-\057\072-\100\133-\140\173-\177]/
  def _NonAlphanumeric
    _tmp = scan(/\A(?-mix:[\000-\057\072-\100\133-\140\173-\177])/)
    set_failed_rule :_NonAlphanumeric unless _tmp
    return _tmp
  end

  # Alphanumeric = (/[0-9A-Za-z]/ | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | "" | " " | "¡" | "¢" | "£" | "¤" | "¥" | "¦" | "§" | "¨" | "©" | "ª" | "«" | "¬" | "­" | "®" | "¯" | "°" | "±" | "²" | "³" | "´" | "µ" | "¶" | "·" | "¸" | "¹" | "º" | "»" | "¼" | "½" | "¾" | "¿" | "À" | "Á" | "Â" | "Ã" | "Ä" | "Å" | "Æ" | "Ç" | "È" | "É" | "Ê" | "Ë" | "Ì" | "Í" | "Î" | "Ï" | "Ð" | "Ñ" | "Ò" | "Ó" | "Ô" | "Õ" | "Ö" | "×" | "Ø" | "Ù" | "Ú" | "Û" | "Ü" | "Ý" | "Þ" | "ß" | "à" | "á" | "â" | "ã" | "ä" | "å" | "æ" | "ç" | "è" | "é" | "ê" | "ë" | "ì" | "í" | "î" | "ï" | "ð" | "ñ" | "ò" | "ó" | "ô" | "õ" | "ö" | "÷" | "ø" | "ù" | "ú" | "û" | "ü" | "ý" | "þ" | "ÿ")
  def _Alphanumeric

    _save = self.pos
    while true # choice
      _tmp = scan(/\A(?-mix:[0-9A-Za-z])/)
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\200")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\201")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\202")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\203")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\204")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\205")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\206")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\207")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\210")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\211")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\212")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\213")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\214")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\215")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\216")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\217")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\220")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\221")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\222")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\223")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\224")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\225")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\226")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\227")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\230")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\231")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\232")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\233")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\234")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\235")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\236")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\237")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\240")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\241")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\242")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\243")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\244")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\245")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\246")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\247")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\250")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\251")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\252")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\253")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\254")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\255")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\256")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\257")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\260")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\261")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\262")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\263")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\264")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\265")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\266")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\267")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\270")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\271")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\272")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\273")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\274")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\275")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\276")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\302\277")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\200")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\201")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\202")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\203")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\204")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\205")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\206")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\207")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\210")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\211")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\212")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\213")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\214")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\215")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\216")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\217")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\220")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\221")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\222")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\223")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\224")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\225")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\226")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\227")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\230")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\231")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\232")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\233")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\234")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\235")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\236")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\237")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\240")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\241")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\242")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\243")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\244")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\245")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\246")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\247")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\250")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\251")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\252")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\253")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\254")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\255")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\256")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\257")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\260")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\261")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\262")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\263")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\264")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\265")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\266")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\267")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\270")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\271")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\272")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\273")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\274")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\275")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\276")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\303\277")
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_Alphanumeric unless _tmp
    return _tmp
  end

  # AlphanumericAscii = /[A-Za-z0-9]/
  def _AlphanumericAscii
    _tmp = scan(/\A(?-mix:[A-Za-z0-9])/)
    set_failed_rule :_AlphanumericAscii unless _tmp
    return _tmp
  end

  # Digit = [0-9]
  def _Digit
    _save = self.pos
    _tmp = get_byte
    if _tmp
      unless _tmp >= 48 and _tmp <= 57
        self.pos = _save
        _tmp = nil
      end
    end
    set_failed_rule :_Digit unless _tmp
    return _tmp
  end

  # BOM = "ï»¿"
  def _BOM
    _tmp = match_string("\303\257\302\273\302\277")
    set_failed_rule :_BOM unless _tmp
    return _tmp
  end

  # HexEntity = < "&" "#" /[Xx]/ /[0-9a-fA-F]+/ ";" >
  def _HexEntity
    _text_start = self.pos

    _save = self.pos
    while true # sequence
      _tmp = match_string("&")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("#")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = scan(/\A(?-mix:[Xx])/)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = scan(/\A(?-mix:[0-9a-fA-F]+)/)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(";")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    if _tmp
      text = get_text(_text_start)
    end
    set_failed_rule :_HexEntity unless _tmp
    return _tmp
  end

  # DecEntity = < "&" "#" /[0-9]+/ ";" >
  def _DecEntity
    _text_start = self.pos

    _save = self.pos
    while true # sequence
      _tmp = match_string("&")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("#")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = scan(/\A(?-mix:[0-9]+)/)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(";")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    if _tmp
      text = get_text(_text_start)
    end
    set_failed_rule :_DecEntity unless _tmp
    return _tmp
  end

  # CharEntity = < "&" /[A-Za-z0-9]+/ ";" >
  def _CharEntity
    _text_start = self.pos

    _save = self.pos
    while true # sequence
      _tmp = match_string("&")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = scan(/\A(?-mix:[A-Za-z0-9]+)/)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(";")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    if _tmp
      text = get_text(_text_start)
    end
    set_failed_rule :_CharEntity unless _tmp
    return _tmp
  end

  # NonindentSpace = ("   " | "  " | " " | "")
  def _NonindentSpace

    _save = self.pos
    while true # choice
      _tmp = match_string("   ")
      break if _tmp
      self.pos = _save
      _tmp = match_string("  ")
      break if _tmp
      self.pos = _save
      _tmp = match_string(" ")
      break if _tmp
      self.pos = _save
      _tmp = match_string("")
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_NonindentSpace unless _tmp
    return _tmp
  end

  # Indent = ("\t" | "    ")
  def _Indent

    _save = self.pos
    while true # choice
      _tmp = match_string("\t")
      break if _tmp
      self.pos = _save
      _tmp = match_string("    ")
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_Indent unless _tmp
    return _tmp
  end

  # IndentedLine = Indent Line
  def _IndentedLine

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Indent)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Line)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_IndentedLine unless _tmp
    return _tmp
  end

  # OptionallyIndentedLine = Indent? Line
  def _OptionallyIndentedLine

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_Indent)
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Line)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_OptionallyIndentedLine unless _tmp
    return _tmp
  end

  # StartList = &. { nil }
  def _StartList

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = get_byte
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  nil ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_StartList unless _tmp
    return _tmp
  end

  # Line = RawLine { raise " $$ = mk_str(yytext); " }
  def _Line

    _save = self.pos
    while true # sequence
      _tmp = apply(:_RawLine)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_str(yytext); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Line unless _tmp
    return _tmp
  end

  # RawLine = (< (!"" !"\n" .)* Newline > | < .+ > Eof)
  def _RawLine

    _save = self.pos
    while true # choice
      _text_start = self.pos

      _save1 = self.pos
      while true # sequence
        while true

          _save3 = self.pos
          while true # sequence
            _save4 = self.pos
            _tmp = match_string("\r")
            _tmp = _tmp ? nil : true
            self.pos = _save4
            unless _tmp
              self.pos = _save3
              break
            end
            _save5 = self.pos
            _tmp = match_string("\n")
            _tmp = _tmp ? nil : true
            self.pos = _save5
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_Newline)
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      if _tmp
        text = get_text(_text_start)
      end
      break if _tmp
      self.pos = _save

      _save6 = self.pos
      while true # sequence
        _text_start = self.pos
        _save7 = self.pos
        _tmp = get_byte
        if _tmp
          while true
            _tmp = get_byte
            break unless _tmp
          end
          _tmp = true
        else
          self.pos = _save7
        end
        if _tmp
          text = get_text(_text_start)
        end
        unless _tmp
          self.pos = _save6
          break
        end
        _tmp = apply(:_Eof)
        unless _tmp
          self.pos = _save6
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_RawLine unless _tmp
    return _tmp
  end

  # SkipBlock = ((!BlankLine RawLine)+ BlankLine* | BlankLine+)
  def _SkipBlock

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _save2 = self.pos

        _save3 = self.pos
        while true # sequence
          _save4 = self.pos
          _tmp = apply(:_BlankLine)
          _tmp = _tmp ? nil : true
          self.pos = _save4
          unless _tmp
            self.pos = _save3
            break
          end
          _tmp = apply(:_RawLine)
          unless _tmp
            self.pos = _save3
          end
          break
        end # end sequence

        if _tmp
          while true

            _save5 = self.pos
            while true # sequence
              _save6 = self.pos
              _tmp = apply(:_BlankLine)
              _tmp = _tmp ? nil : true
              self.pos = _save6
              unless _tmp
                self.pos = _save5
                break
              end
              _tmp = apply(:_RawLine)
              unless _tmp
                self.pos = _save5
              end
              break
            end # end sequence

            break unless _tmp
          end
          _tmp = true
        else
          self.pos = _save2
        end
        unless _tmp
          self.pos = _save1
          break
        end
        while true
          _tmp = apply(:_BlankLine)
          break unless _tmp
        end
        _tmp = true
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      _save8 = self.pos
      _tmp = apply(:_BlankLine)
      if _tmp
        while true
          _tmp = apply(:_BlankLine)
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save8
      end
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_SkipBlock unless _tmp
    return _tmp
  end

  # ExtendedSpecialChar = (&{ extension(:EXT_SMART) } ("." | "-" | "'" | "\"") | &{ extension(:EXT_NOTES) } "^")
  def _ExtendedSpecialChar

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _save2 = self.pos
        _tmp = begin;  extension(:EXT_SMART) ; end
        self.pos = _save2
        unless _tmp
          self.pos = _save1
          break
        end

        _save3 = self.pos
        while true # choice
          _tmp = match_string(".")
          break if _tmp
          self.pos = _save3
          _tmp = match_string("-")
          break if _tmp
          self.pos = _save3
          _tmp = match_string("'")
          break if _tmp
          self.pos = _save3
          _tmp = match_string("\"")
          break if _tmp
          self.pos = _save3
          break
        end # end choice

        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save4 = self.pos
      while true # sequence
        _save5 = self.pos
        _tmp = begin;  extension(:EXT_NOTES) ; end
        self.pos = _save5
        unless _tmp
          self.pos = _save4
          break
        end
        _tmp = match_string("^")
        unless _tmp
          self.pos = _save4
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_ExtendedSpecialChar unless _tmp
    return _tmp
  end

  # Smart = &{  extension(:EXT_SMART)  } (Ellipsis | Dash | SingleQuoted | DoubleQuoted | Apostrophe)
  def _Smart

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = begin;   extension(:EXT_SMART)  ; end
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end

      _save2 = self.pos
      while true # choice
        _tmp = apply(:_Ellipsis)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_Dash)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_SingleQuoted)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_DoubleQuoted)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_Apostrophe)
        break if _tmp
        self.pos = _save2
        break
      end # end choice

      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Smart unless _tmp
    return _tmp
  end

  # Apostrophe = "'" { raise " $$ = mk_element(APOSTROPHE); " }
  def _Apostrophe

    _save = self.pos
    while true # sequence
      _tmp = match_string("'")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_element(APOSTROPHE); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Apostrophe unless _tmp
    return _tmp
  end

  # Ellipsis = ("..." | ". . .") { raise " $$ = mk_element(ELLIPSIS); " }
  def _Ellipsis

    _save = self.pos
    while true # sequence

      _save1 = self.pos
      while true # choice
        _tmp = match_string("...")
        break if _tmp
        self.pos = _save1
        _tmp = match_string(". . .")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_element(ELLIPSIS); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Ellipsis unless _tmp
    return _tmp
  end

  # Dash = (EmDash | EnDash)
  def _Dash

    _save = self.pos
    while true # choice
      _tmp = apply(:_EmDash)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_EnDash)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_Dash unless _tmp
    return _tmp
  end

  # EnDash = "-" &Digit { raise " $$ = mk_element(ENDASH); " }
  def _EnDash

    _save = self.pos
    while true # sequence
      _tmp = match_string("-")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_Digit)
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_element(ENDASH); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_EnDash unless _tmp
    return _tmp
  end

  # EmDash = ("---" | "--") { raise " $$ = mk_element(EMDASH); " }
  def _EmDash

    _save = self.pos
    while true # sequence

      _save1 = self.pos
      while true # choice
        _tmp = match_string("---")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("--")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_element(EMDASH); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_EmDash unless _tmp
    return _tmp
  end

  # SingleQuoteStart = "'" !(Spacechar | Newline)
  def _SingleQuoteStart

    _save = self.pos
    while true # sequence
      _tmp = match_string("'")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos

      _save2 = self.pos
      while true # choice
        _tmp = apply(:_Spacechar)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_Newline)
        break if _tmp
        self.pos = _save2
        break
      end # end choice

      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_SingleQuoteStart unless _tmp
    return _tmp
  end

  # SingleQuoteEnd = "'" !Alphanumeric
  def _SingleQuoteEnd

    _save = self.pos
    while true # sequence
      _tmp = match_string("'")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_Alphanumeric)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_SingleQuoteEnd unless _tmp
    return _tmp
  end

  # SingleQuoted = SingleQuoteStart StartList:a (!SingleQuoteEnd b:inline { raise " a = cons(b, a); " })+ SingleQuoteEnd { raise " $$ = mk_list(SINGLEQUOTED, a); " }
  def _SingleQuoted

    _save = self.pos
    while true # sequence
      _tmp = apply(:_SingleQuoteStart)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _save3 = self.pos
        _tmp = apply(:_SingleQuoteEnd)
        _tmp = _tmp ? nil : true
        self.pos = _save3
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_b)
        inline = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  raise " a = cons(b, a); " ; end
        _tmp = true
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      if _tmp
        while true

          _save4 = self.pos
          while true # sequence
            _save5 = self.pos
            _tmp = apply(:_SingleQuoteEnd)
            _tmp = _tmp ? nil : true
            self.pos = _save5
            unless _tmp
              self.pos = _save4
              break
            end
            _tmp = apply(:_b)
            inline = @result
            unless _tmp
              self.pos = _save4
              break
            end
            @result = begin;  raise " a = cons(b, a); " ; end
            _tmp = true
            unless _tmp
              self.pos = _save4
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_SingleQuoteEnd)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_list(SINGLEQUOTED, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_SingleQuoted unless _tmp
    return _tmp
  end

  # DoubleQuoteStart = "\""
  def _DoubleQuoteStart
    _tmp = match_string("\"")
    set_failed_rule :_DoubleQuoteStart unless _tmp
    return _tmp
  end

  # DoubleQuoteEnd = "\""
  def _DoubleQuoteEnd
    _tmp = match_string("\"")
    set_failed_rule :_DoubleQuoteEnd unless _tmp
    return _tmp
  end

  # DoubleQuoted = DoubleQuoteStart StartList:a (!DoubleQuoteEnd b:inline { raise " a = cons(b, a); " })+ DoubleQuoteEnd { raise " $$ = mk_list(DOUBLEQUOTED, a); " }
  def _DoubleQuoted

    _save = self.pos
    while true # sequence
      _tmp = apply(:_DoubleQuoteStart)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _save3 = self.pos
        _tmp = apply(:_DoubleQuoteEnd)
        _tmp = _tmp ? nil : true
        self.pos = _save3
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_b)
        inline = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  raise " a = cons(b, a); " ; end
        _tmp = true
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      if _tmp
        while true

          _save4 = self.pos
          while true # sequence
            _save5 = self.pos
            _tmp = apply(:_DoubleQuoteEnd)
            _tmp = _tmp ? nil : true
            self.pos = _save5
            unless _tmp
              self.pos = _save4
              break
            end
            _tmp = apply(:_b)
            inline = @result
            unless _tmp
              self.pos = _save4
              break
            end
            @result = begin;  raise " a = cons(b, a); " ; end
            _tmp = true
            unless _tmp
              self.pos = _save4
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_DoubleQuoteEnd)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_list(DOUBLEQUOTED, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_DoubleQuoted unless _tmp
    return _tmp
  end

  # NoteReference = &{ extension(:EXT_NOTES) } RawNoteReference:ref {   raise 'element *match;                     if (find_note(&match, ref->contents.str)) {                         $$ = mk_element(NOTE);                         assert(match->children != NULL);                         $$->children = match->children;                         $$->contents.str = 0;                     } else {                         char *s;                         s = malloc(strlen(ref->contents.str) + 4);                         sprintf(s, "[^%s]", ref->contents.str);                         $$ = mk_str(s);                         free(s);                     }'                 }
  def _NoteReference

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = begin;  extension(:EXT_NOTES) ; end
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_RawNoteReference)
      ref = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;    raise 'element *match;
                    if (find_note(&match, ref->contents.str)) {
                        $$ = mk_element(NOTE);
                        assert(match->children != NULL);
                        $$->children = match->children;
                        $$->contents.str = 0;
                    } else {
                        char *s;
                        s = malloc(strlen(ref->contents.str) + 4);
                        sprintf(s, "[^%s]", ref->contents.str);
                        $$ = mk_str(s);
                        free(s);
                    }'
                ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_NoteReference unless _tmp
    return _tmp
  end

  # RawNoteReference = "[^" < (!Newline !"]" .)+ > "]" { raise " $$ = mk_str(yytext); " }
  def _RawNoteReference

    _save = self.pos
    while true # sequence
      _tmp = match_string("[^")
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _save3 = self.pos
        _tmp = apply(:_Newline)
        _tmp = _tmp ? nil : true
        self.pos = _save3
        unless _tmp
          self.pos = _save2
          break
        end
        _save4 = self.pos
        _tmp = match_string("]")
        _tmp = _tmp ? nil : true
        self.pos = _save4
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = get_byte
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      if _tmp
        while true

          _save5 = self.pos
          while true # sequence
            _save6 = self.pos
            _tmp = apply(:_Newline)
            _tmp = _tmp ? nil : true
            self.pos = _save6
            unless _tmp
              self.pos = _save5
              break
            end
            _save7 = self.pos
            _tmp = match_string("]")
            _tmp = _tmp ? nil : true
            self.pos = _save7
            unless _tmp
              self.pos = _save5
              break
            end
            _tmp = get_byte
            unless _tmp
              self.pos = _save5
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("]")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " $$ = mk_str(yytext); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_RawNoteReference unless _tmp
    return _tmp
  end

  # Note = &{ extension(:EXT_NOTES) } NonindentSpace ref:rawNoteReference ":" Sp StartList:a RawNoteBlock { raise " a = cons($$, a); " } (&Indent RawNoteBlock { raise " a = cons($$, a); " })* {   raise '$$ = mk_list(NOTE, a);                     $$->contents.str = strdup(ref->contents.str); '                 }
  def _Note

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = begin;  extension(:EXT_NOTES) ; end
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_NonindentSpace)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_ref)
      rawNoteReference = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(":")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_RawNoteBlock)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " a = cons($$, a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save3 = self.pos
        while true # sequence
          _save4 = self.pos
          _tmp = apply(:_Indent)
          self.pos = _save4
          unless _tmp
            self.pos = _save3
            break
          end
          _tmp = apply(:_RawNoteBlock)
          unless _tmp
            self.pos = _save3
            break
          end
          @result = begin;  raise " a = cons($$, a); " ; end
          _tmp = true
          unless _tmp
            self.pos = _save3
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;    raise '$$ = mk_list(NOTE, a);
                    $$->contents.str = strdup(ref->contents.str); '
                ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Note unless _tmp
    return _tmp
  end

  # InlineNote = &{ extension(:EXT_NOTES) } "^[" StartList:a (!"]" Inline { raise " a = cons($$, a); " })+ "]" { raise '$$ = mk_list(NOTE, a);                   $$->contents.str = 0; '}
  def _InlineNote

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = begin;  extension(:EXT_NOTES) ; end
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("^[")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos

      _save3 = self.pos
      while true # sequence
        _save4 = self.pos
        _tmp = match_string("]")
        _tmp = _tmp ? nil : true
        self.pos = _save4
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = apply(:_Inline)
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  raise " a = cons($$, a); " ; end
        _tmp = true
        unless _tmp
          self.pos = _save3
        end
        break
      end # end sequence

      if _tmp
        while true

          _save5 = self.pos
          while true # sequence
            _save6 = self.pos
            _tmp = match_string("]")
            _tmp = _tmp ? nil : true
            self.pos = _save6
            unless _tmp
              self.pos = _save5
              break
            end
            _tmp = apply(:_Inline)
            unless _tmp
              self.pos = _save5
              break
            end
            @result = begin;  raise " a = cons($$, a); " ; end
            _tmp = true
            unless _tmp
              self.pos = _save5
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save2
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("]")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise '$$ = mk_list(NOTE, a);
                  $$->contents.str = 0; '; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_InlineNote unless _tmp
    return _tmp
  end

  # Notes = StartList:a (b:note { raise " a = cons(b, a); " } | SkipBlock)* { raise " notes = reverse(a); " }
  def _Notes

    _save = self.pos
    while true # sequence
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice

          _save3 = self.pos
          while true # sequence
            _tmp = apply(:_b)
            note = @result
            unless _tmp
              self.pos = _save3
              break
            end
            @result = begin;  raise " a = cons(b, a); " ; end
            _tmp = true
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break if _tmp
          self.pos = _save2
          _tmp = apply(:_SkipBlock)
          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " notes = reverse(a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Notes unless _tmp
    return _tmp
  end

  # RawNoteBlock = StartList:a (!BlankLine OptionallyIndentedLine { raise " a = cons($$, a); " })+ < BlankLine* > { raise " a = cons(mk_str(yytext), a); " } {   raise '$$ = mk_str_from_list(a, true);                     $$->key = RAW; '                 }
  def _RawNoteBlock

    _save = self.pos
    while true # sequence
      _tmp = apply(:_StartList)
      a = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _save3 = self.pos
        _tmp = apply(:_BlankLine)
        _tmp = _tmp ? nil : true
        self.pos = _save3
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_OptionallyIndentedLine)
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  raise " a = cons($$, a); " ; end
        _tmp = true
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      if _tmp
        while true

          _save4 = self.pos
          while true # sequence
            _save5 = self.pos
            _tmp = apply(:_BlankLine)
            _tmp = _tmp ? nil : true
            self.pos = _save5
            unless _tmp
              self.pos = _save4
              break
            end
            _tmp = apply(:_OptionallyIndentedLine)
            unless _tmp
              self.pos = _save4
              break
            end
            @result = begin;  raise " a = cons($$, a); " ; end
            _tmp = true
            unless _tmp
              self.pos = _save4
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      while true
        _tmp = apply(:_BlankLine)
        break unless _tmp
      end
      _tmp = true
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  raise " a = cons(mk_str(yytext), a); " ; end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;    raise '$$ = mk_str_from_list(a, true);
                    $$->key = RAW; '
                ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_RawNoteBlock unless _tmp
    return _tmp
  end

  Rules = {}
  Rules[:_root] = rule_info("root", "Doc")
  Rules[:_Doc] = rule_info("Doc", "BOM? StartList:a (Block:b { \"a = cons($$, a);\"; a = [b, a] })* { 'parse_result = reverse(a); '; a.reverse }")
  Rules[:_Block] = rule_info("Block", "BlankLine* (BlockQuote | Verbatim | Note | Reference | HorizontalRule | Heading | OrderedList | BulletList | HtmlBlock | StyleBlock | Para | Plain)")
  Rules[:_Para] = rule_info("Para", "NonindentSpace Inlines:a BlankLine+ { raise \"$$ = a; $$->key = PARA;\" }")
  Rules[:_Plain] = rule_info("Plain", "Inlines:a { a }")
  Rules[:_AtxInline] = rule_info("AtxInline", "!Newline !(Sp? \"\#\"* Sp Newline) Inline")
  Rules[:_AtxStart] = rule_info("AtxStart", "< (\"\#\#\#\#\#\#\" | \"\#\#\#\#\#\" | \"\#\#\#\#\" | \"\#\#\#\" | \"\#\#\" | \"\#\") > { raise \" $$ = mk_element(H1 + (strlen(yytext) - 1)); \" }")
  Rules[:_AtxHeading] = rule_info("AtxHeading", "AtxStart:s Sp? StartList:a (AtxInline { raise \" a = cons($$, a); \" })+ (Sp? \"\#\"* Sp)? Newline { raise \"$$ = mk_list(s->key, a);               free(s);\" }")
  Rules[:_SetextHeading] = rule_info("SetextHeading", "(SetextHeading1 | SetextHeading2)")
  Rules[:_SetextBottom1] = rule_info("SetextBottom1", "\"===\" \"=\"* Newline")
  Rules[:_SetextBottom2] = rule_info("SetextBottom2", "\"---\" \"-\"* Newline")
  Rules[:_SetextHeading1] = rule_info("SetextHeading1", "&(RawLine SetextBottom1) StartList:a (!Endline Inline { raise \" a = cons($$, a); \" })+ Sp? Newline SetextBottom1 { raise \" $$ = mk_list(H1, a); \" }")
  Rules[:_SetextHeading2] = rule_info("SetextHeading2", "&(RawLine SetextBottom2) StartList:a (!Endline Inline { raise \" a = cons($$, a); \" })+ Sp? Newline SetextBottom2 { raise \" $$ = mk_list(H2, a); \" }")
  Rules[:_Heading] = rule_info("Heading", "(SetextHeading | AtxHeading)")
  Rules[:_BlockQuote] = rule_info("BlockQuote", "BlockQuoteRaw:a {  raise \"$$ = mk_element(BLOCKQUOTE);                 $$->children = a;\"              }")
  Rules[:_BlockQuoteRaw] = rule_info("BlockQuoteRaw", "StartList:a (\">\" \" \"? Line { raise \" a = cons($$, a); \" } (!\">\" !BlankLine Line { raise \" a = cons($$, a); \" })* (BlankLine { raise ' a = cons(mk_str(\"\\n\"), a); ' })*)+ {   raise '$$ = mk_str_from_list(a, true);                      $$->key = RAW;'                  }")
  Rules[:_NonblankIndentedLine] = rule_info("NonblankIndentedLine", "!BlankLine IndentedLine")
  Rules[:_VerbatimChunk] = rule_info("VerbatimChunk", "StartList:a (BlankLine { raise ' a = cons(mk_str(\"\\n\"), a); ' })* (NonblankIndentedLine { raise \" a = cons($$, a); \" })+ { raise \" $$ = mk_str_from_list(a, false); \" }")
  Rules[:_Verbatim] = rule_info("Verbatim", "StartList:a (VerbatimChunk { raise \" a = cons($$, a); \" })+ { raise '$$ = mk_str_from_list(a, false);                  $$->key = VERBATIM;' }")
  Rules[:_HorizontalRule] = rule_info("HorizontalRule", "NonindentSpace (\"*\" Sp \"*\" Sp \"*\" (Sp \"*\")* | \"-\" Sp \"-\" Sp \"-\" (Sp \"-\")* | \"_\" Sp \"_\" Sp \"_\" (Sp \"_\")*) Sp Newline BlankLine+ { raise \" $$ = mk_element(HRULE); \" }")
  Rules[:_Bullet] = rule_info("Bullet", "!HorizontalRule NonindentSpace (\"+\" | \"*\" | \"-\") Spacechar+")
  Rules[:_BulletList] = rule_info("BulletList", "&Bullet (ListTight | ListLoose) { raise \" $$->key = BULLETLIST; \" }")
  Rules[:_ListTight] = rule_info("ListTight", "StartList:a (ListItemTight { raise \" a = cons($$, a); \" })+ BlankLine* !(Bullet | Enumerator) { raise \" $$ = mk_list(LIST, a); \" }")
  Rules[:_ListLoose] = rule_info("ListLoose", "StartList:a (b:listItem BlankLine* {   raise 'element *li;                   li = b->children;                   li->contents.str = realloc(li->contents.str, strlen(li->contents.str) + 3);                   strcat(li->contents.str, \"\\n\\n\");  /* In loose list, \\n\\n added to end of each element */                   a = cons(b, a);'               })+ { raise \" $$ = mk_list(LIST, a); \" }")
  Rules[:_ListItem] = rule_info("ListItem", "(Bullet | Enumerator) StartList:a ListBlock { raise \" a = cons($$, a); \" } (ListContinuationBlock { raise \" a = cons($$, a); \" })* {  raise 'element *raw;                raw = mk_str_from_list(a, false);                raw->key = RAW;                $$ = mk_element(LISTITEM);                $$->children = raw;'             }")
  Rules[:_ListItemTight] = rule_info("ListItemTight", "(Bullet | Enumerator) StartList:a ListBlock { raise \" a = cons($$, a); \" } (!BlankLine ListContinuationBlock { raise \" a = cons($$, a); \" })* !ListContinuationBlock {  raise 'element *raw;                raw = mk_str_from_list(a, false);                raw->key = RAW;                $$ = mk_element(LISTITEM);                $$->children = raw;'             }")
  Rules[:_ListBlock] = rule_info("ListBlock", "StartList:a !BlankLine Line { raise \" a = cons($$, a); \" } (ListBlockLine { raise \" a = cons($$, a); \" })* { raise \" $$ = mk_str_from_list(a, false); \" }")
  Rules[:_ListContinuationBlock] = rule_info("ListContinuationBlock", "StartList:a < BlankLine* > {   raise 'if (strlen(yytext) == 0)                                    a = cons(mk_str(\"\\001\"), a); /* block separator */                               else                                    a = cons(mk_str(yytext), a);' } (Indent ListBlock { raise \" a = cons($$, a); \" })+ { raise \"  $$ = mk_str_from_list(a, false); \" }")
  Rules[:_Enumerator] = rule_info("Enumerator", "NonindentSpace [0-9]+ \".\" Spacechar+")
  Rules[:_OrderedList] = rule_info("OrderedList", "&Enumerator (ListTight | ListLoose) { raise \" $$->key = ORDEREDLIST; \" }")
  Rules[:_ListBlockLine] = rule_info("ListBlockLine", "!BlankLine !(Indent? (Bullet | Enumerator)) !HorizontalRule OptionallyIndentedLine")
  Rules[:_HtmlBlockOpenAddress] = rule_info("HtmlBlockOpenAddress", "\"<\" Spnl (\"address\" | \"ADDRESS\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseAddress] = rule_info("HtmlBlockCloseAddress", "\"<\" Spnl \"/\" (\"address\" | \"ADDRESS\") Spnl \">\"")
  Rules[:_HtmlBlockAddress] = rule_info("HtmlBlockAddress", "HtmlBlockOpenAddress (HtmlBlockAddress | !HtmlBlockCloseAddress .)* HtmlBlockCloseAddress")
  Rules[:_HtmlBlockOpenBlockquote] = rule_info("HtmlBlockOpenBlockquote", "\"<\" Spnl (\"blockquote\" | \"BLOCKQUOTE\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseBlockquote] = rule_info("HtmlBlockCloseBlockquote", "\"<\" Spnl \"/\" (\"blockquote\" | \"BLOCKQUOTE\") Spnl \">\"")
  Rules[:_HtmlBlockBlockquote] = rule_info("HtmlBlockBlockquote", "HtmlBlockOpenBlockquote (HtmlBlockBlockquote | !HtmlBlockCloseBlockquote .)* HtmlBlockCloseBlockquote")
  Rules[:_HtmlBlockOpenCenter] = rule_info("HtmlBlockOpenCenter", "\"<\" Spnl (\"center\" | \"CENTER\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseCenter] = rule_info("HtmlBlockCloseCenter", "\"<\" Spnl \"/\" (\"center\" | \"CENTER\") Spnl \">\"")
  Rules[:_HtmlBlockCenter] = rule_info("HtmlBlockCenter", "HtmlBlockOpenCenter (HtmlBlockCenter | !HtmlBlockCloseCenter .)* HtmlBlockCloseCenter")
  Rules[:_HtmlBlockOpenDir] = rule_info("HtmlBlockOpenDir", "\"<\" Spnl (\"dir\" | \"DIR\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseDir] = rule_info("HtmlBlockCloseDir", "\"<\" Spnl \"/\" (\"dir\" | \"DIR\") Spnl \">\"")
  Rules[:_HtmlBlockDir] = rule_info("HtmlBlockDir", "HtmlBlockOpenDir (HtmlBlockDir | !HtmlBlockCloseDir .)* HtmlBlockCloseDir")
  Rules[:_HtmlBlockOpenDiv] = rule_info("HtmlBlockOpenDiv", "\"<\" Spnl (\"div\" | \"DIV\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseDiv] = rule_info("HtmlBlockCloseDiv", "\"<\" Spnl \"/\" (\"div\" | \"DIV\") Spnl \">\"")
  Rules[:_HtmlBlockDiv] = rule_info("HtmlBlockDiv", "HtmlBlockOpenDiv (HtmlBlockDiv | !HtmlBlockCloseDiv .)* HtmlBlockCloseDiv")
  Rules[:_HtmlBlockOpenDl] = rule_info("HtmlBlockOpenDl", "\"<\" Spnl (\"dl\" | \"DL\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseDl] = rule_info("HtmlBlockCloseDl", "\"<\" Spnl \"/\" (\"dl\" | \"DL\") Spnl \">\"")
  Rules[:_HtmlBlockDl] = rule_info("HtmlBlockDl", "HtmlBlockOpenDl (HtmlBlockDl | !HtmlBlockCloseDl .)* HtmlBlockCloseDl")
  Rules[:_HtmlBlockOpenFieldset] = rule_info("HtmlBlockOpenFieldset", "\"<\" Spnl (\"fieldset\" | \"FIELDSET\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseFieldset] = rule_info("HtmlBlockCloseFieldset", "\"<\" Spnl \"/\" (\"fieldset\" | \"FIELDSET\") Spnl \">\"")
  Rules[:_HtmlBlockFieldset] = rule_info("HtmlBlockFieldset", "HtmlBlockOpenFieldset (HtmlBlockFieldset | !HtmlBlockCloseFieldset .)* HtmlBlockCloseFieldset")
  Rules[:_HtmlBlockOpenForm] = rule_info("HtmlBlockOpenForm", "\"<\" Spnl (\"form\" | \"FORM\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseForm] = rule_info("HtmlBlockCloseForm", "\"<\" Spnl \"/\" (\"form\" | \"FORM\") Spnl \">\"")
  Rules[:_HtmlBlockForm] = rule_info("HtmlBlockForm", "HtmlBlockOpenForm (HtmlBlockForm | !HtmlBlockCloseForm .)* HtmlBlockCloseForm")
  Rules[:_HtmlBlockOpenH1] = rule_info("HtmlBlockOpenH1", "\"<\" Spnl (\"h1\" | \"H1\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseH1] = rule_info("HtmlBlockCloseH1", "\"<\" Spnl \"/\" (\"h1\" | \"H1\") Spnl \">\"")
  Rules[:_HtmlBlockH1] = rule_info("HtmlBlockH1", "HtmlBlockOpenH1 (HtmlBlockH1 | !HtmlBlockCloseH1 .)* HtmlBlockCloseH1")
  Rules[:_HtmlBlockOpenH2] = rule_info("HtmlBlockOpenH2", "\"<\" Spnl (\"h2\" | \"H2\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseH2] = rule_info("HtmlBlockCloseH2", "\"<\" Spnl \"/\" (\"h2\" | \"H2\") Spnl \">\"")
  Rules[:_HtmlBlockH2] = rule_info("HtmlBlockH2", "HtmlBlockOpenH2 (HtmlBlockH2 | !HtmlBlockCloseH2 .)* HtmlBlockCloseH2")
  Rules[:_HtmlBlockOpenH3] = rule_info("HtmlBlockOpenH3", "\"<\" Spnl (\"h3\" | \"H3\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseH3] = rule_info("HtmlBlockCloseH3", "\"<\" Spnl \"/\" (\"h3\" | \"H3\") Spnl \">\"")
  Rules[:_HtmlBlockH3] = rule_info("HtmlBlockH3", "HtmlBlockOpenH3 (HtmlBlockH3 | !HtmlBlockCloseH3 .)* HtmlBlockCloseH3")
  Rules[:_HtmlBlockOpenH4] = rule_info("HtmlBlockOpenH4", "\"<\" Spnl (\"h4\" | \"H4\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseH4] = rule_info("HtmlBlockCloseH4", "\"<\" Spnl \"/\" (\"h4\" | \"H4\") Spnl \">\"")
  Rules[:_HtmlBlockH4] = rule_info("HtmlBlockH4", "HtmlBlockOpenH4 (HtmlBlockH4 | !HtmlBlockCloseH4 .)* HtmlBlockCloseH4")
  Rules[:_HtmlBlockOpenH5] = rule_info("HtmlBlockOpenH5", "\"<\" Spnl (\"h5\" | \"H5\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseH5] = rule_info("HtmlBlockCloseH5", "\"<\" Spnl \"/\" (\"h5\" | \"H5\") Spnl \">\"")
  Rules[:_HtmlBlockH5] = rule_info("HtmlBlockH5", "HtmlBlockOpenH5 (HtmlBlockH5 | !HtmlBlockCloseH5 .)* HtmlBlockCloseH5")
  Rules[:_HtmlBlockOpenH6] = rule_info("HtmlBlockOpenH6", "\"<\" Spnl (\"h6\" | \"H6\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseH6] = rule_info("HtmlBlockCloseH6", "\"<\" Spnl \"/\" (\"h6\" | \"H6\") Spnl \">\"")
  Rules[:_HtmlBlockH6] = rule_info("HtmlBlockH6", "HtmlBlockOpenH6 (HtmlBlockH6 | !HtmlBlockCloseH6 .)* HtmlBlockCloseH6")
  Rules[:_HtmlBlockOpenMenu] = rule_info("HtmlBlockOpenMenu", "\"<\" Spnl (\"menu\" | \"MENU\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseMenu] = rule_info("HtmlBlockCloseMenu", "\"<\" Spnl \"/\" (\"menu\" | \"MENU\") Spnl \">\"")
  Rules[:_HtmlBlockMenu] = rule_info("HtmlBlockMenu", "HtmlBlockOpenMenu (HtmlBlockMenu | !HtmlBlockCloseMenu .)* HtmlBlockCloseMenu")
  Rules[:_HtmlBlockOpenNoframes] = rule_info("HtmlBlockOpenNoframes", "\"<\" Spnl (\"noframes\" | \"NOFRAMES\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseNoframes] = rule_info("HtmlBlockCloseNoframes", "\"<\" Spnl \"/\" (\"noframes\" | \"NOFRAMES\") Spnl \">\"")
  Rules[:_HtmlBlockNoframes] = rule_info("HtmlBlockNoframes", "HtmlBlockOpenNoframes (HtmlBlockNoframes | !HtmlBlockCloseNoframes .)* HtmlBlockCloseNoframes")
  Rules[:_HtmlBlockOpenNoscript] = rule_info("HtmlBlockOpenNoscript", "\"<\" Spnl (\"noscript\" | \"NOSCRIPT\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseNoscript] = rule_info("HtmlBlockCloseNoscript", "\"<\" Spnl \"/\" (\"noscript\" | \"NOSCRIPT\") Spnl \">\"")
  Rules[:_HtmlBlockNoscript] = rule_info("HtmlBlockNoscript", "HtmlBlockOpenNoscript (HtmlBlockNoscript | !HtmlBlockCloseNoscript .)* HtmlBlockCloseNoscript")
  Rules[:_HtmlBlockOpenOl] = rule_info("HtmlBlockOpenOl", "\"<\" Spnl (\"ol\" | \"OL\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseOl] = rule_info("HtmlBlockCloseOl", "\"<\" Spnl \"/\" (\"ol\" | \"OL\") Spnl \">\"")
  Rules[:_HtmlBlockOl] = rule_info("HtmlBlockOl", "HtmlBlockOpenOl (HtmlBlockOl | !HtmlBlockCloseOl .)* HtmlBlockCloseOl")
  Rules[:_HtmlBlockOpenP] = rule_info("HtmlBlockOpenP", "\"<\" Spnl (\"p\" | \"P\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseP] = rule_info("HtmlBlockCloseP", "\"<\" Spnl \"/\" (\"p\" | \"P\") Spnl \">\"")
  Rules[:_HtmlBlockP] = rule_info("HtmlBlockP", "HtmlBlockOpenP (HtmlBlockP | !HtmlBlockCloseP .)* HtmlBlockCloseP")
  Rules[:_HtmlBlockOpenPre] = rule_info("HtmlBlockOpenPre", "\"<\" Spnl (\"pre\" | \"PRE\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockClosePre] = rule_info("HtmlBlockClosePre", "\"<\" Spnl \"/\" (\"pre\" | \"PRE\") Spnl \">\"")
  Rules[:_HtmlBlockPre] = rule_info("HtmlBlockPre", "HtmlBlockOpenPre (HtmlBlockPre | !HtmlBlockClosePre .)* HtmlBlockClosePre")
  Rules[:_HtmlBlockOpenTable] = rule_info("HtmlBlockOpenTable", "\"<\" Spnl (\"table\" | \"TABLE\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseTable] = rule_info("HtmlBlockCloseTable", "\"<\" Spnl \"/\" (\"table\" | \"TABLE\") Spnl \">\"")
  Rules[:_HtmlBlockTable] = rule_info("HtmlBlockTable", "HtmlBlockOpenTable (HtmlBlockTable | !HtmlBlockCloseTable .)* HtmlBlockCloseTable")
  Rules[:_HtmlBlockOpenUl] = rule_info("HtmlBlockOpenUl", "\"<\" Spnl (\"ul\" | \"UL\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseUl] = rule_info("HtmlBlockCloseUl", "\"<\" Spnl \"/\" (\"ul\" | \"UL\") Spnl \">\"")
  Rules[:_HtmlBlockUl] = rule_info("HtmlBlockUl", "HtmlBlockOpenUl (HtmlBlockUl | !HtmlBlockCloseUl .)* HtmlBlockCloseUl")
  Rules[:_HtmlBlockOpenDd] = rule_info("HtmlBlockOpenDd", "\"<\" Spnl (\"dd\" | \"DD\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseDd] = rule_info("HtmlBlockCloseDd", "\"<\" Spnl \"/\" (\"dd\" | \"DD\") Spnl \">\"")
  Rules[:_HtmlBlockDd] = rule_info("HtmlBlockDd", "HtmlBlockOpenDd (HtmlBlockDd | !HtmlBlockCloseDd .)* HtmlBlockCloseDd")
  Rules[:_HtmlBlockOpenDt] = rule_info("HtmlBlockOpenDt", "\"<\" Spnl (\"dt\" | \"DT\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseDt] = rule_info("HtmlBlockCloseDt", "\"<\" Spnl \"/\" (\"dt\" | \"DT\") Spnl \">\"")
  Rules[:_HtmlBlockDt] = rule_info("HtmlBlockDt", "HtmlBlockOpenDt (HtmlBlockDt | !HtmlBlockCloseDt .)* HtmlBlockCloseDt")
  Rules[:_HtmlBlockOpenFrameset] = rule_info("HtmlBlockOpenFrameset", "\"<\" Spnl (\"frameset\" | \"FRAMESET\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseFrameset] = rule_info("HtmlBlockCloseFrameset", "\"<\" Spnl \"/\" (\"frameset\" | \"FRAMESET\") Spnl \">\"")
  Rules[:_HtmlBlockFrameset] = rule_info("HtmlBlockFrameset", "HtmlBlockOpenFrameset (HtmlBlockFrameset | !HtmlBlockCloseFrameset .)* HtmlBlockCloseFrameset")
  Rules[:_HtmlBlockOpenLi] = rule_info("HtmlBlockOpenLi", "\"<\" Spnl (\"li\" | \"LI\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseLi] = rule_info("HtmlBlockCloseLi", "\"<\" Spnl \"/\" (\"li\" | \"LI\") Spnl \">\"")
  Rules[:_HtmlBlockLi] = rule_info("HtmlBlockLi", "HtmlBlockOpenLi (HtmlBlockLi | !HtmlBlockCloseLi .)* HtmlBlockCloseLi")
  Rules[:_HtmlBlockOpenTbody] = rule_info("HtmlBlockOpenTbody", "\"<\" Spnl (\"tbody\" | \"TBODY\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseTbody] = rule_info("HtmlBlockCloseTbody", "\"<\" Spnl \"/\" (\"tbody\" | \"TBODY\") Spnl \">\"")
  Rules[:_HtmlBlockTbody] = rule_info("HtmlBlockTbody", "HtmlBlockOpenTbody (HtmlBlockTbody | !HtmlBlockCloseTbody .)* HtmlBlockCloseTbody")
  Rules[:_HtmlBlockOpenTd] = rule_info("HtmlBlockOpenTd", "\"<\" Spnl (\"td\" | \"TD\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseTd] = rule_info("HtmlBlockCloseTd", "\"<\" Spnl \"/\" (\"td\" | \"TD\") Spnl \">\"")
  Rules[:_HtmlBlockTd] = rule_info("HtmlBlockTd", "HtmlBlockOpenTd (HtmlBlockTd | !HtmlBlockCloseTd .)* HtmlBlockCloseTd")
  Rules[:_HtmlBlockOpenTfoot] = rule_info("HtmlBlockOpenTfoot", "\"<\" Spnl (\"tfoot\" | \"TFOOT\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseTfoot] = rule_info("HtmlBlockCloseTfoot", "\"<\" Spnl \"/\" (\"tfoot\" | \"TFOOT\") Spnl \">\"")
  Rules[:_HtmlBlockTfoot] = rule_info("HtmlBlockTfoot", "HtmlBlockOpenTfoot (HtmlBlockTfoot | !HtmlBlockCloseTfoot .)* HtmlBlockCloseTfoot")
  Rules[:_HtmlBlockOpenTh] = rule_info("HtmlBlockOpenTh", "\"<\" Spnl (\"th\" | \"TH\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseTh] = rule_info("HtmlBlockCloseTh", "\"<\" Spnl \"/\" (\"th\" | \"TH\") Spnl \">\"")
  Rules[:_HtmlBlockTh] = rule_info("HtmlBlockTh", "HtmlBlockOpenTh (HtmlBlockTh | !HtmlBlockCloseTh .)* HtmlBlockCloseTh")
  Rules[:_HtmlBlockOpenThead] = rule_info("HtmlBlockOpenThead", "\"<\" Spnl (\"thead\" | \"THEAD\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseThead] = rule_info("HtmlBlockCloseThead", "\"<\" Spnl \"/\" (\"thead\" | \"THEAD\") Spnl \">\"")
  Rules[:_HtmlBlockThead] = rule_info("HtmlBlockThead", "HtmlBlockOpenThead (HtmlBlockThead | !HtmlBlockCloseThead .)* HtmlBlockCloseThead")
  Rules[:_HtmlBlockOpenTr] = rule_info("HtmlBlockOpenTr", "\"<\" Spnl (\"tr\" | \"TR\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseTr] = rule_info("HtmlBlockCloseTr", "\"<\" Spnl \"/\" (\"tr\" | \"TR\") Spnl \">\"")
  Rules[:_HtmlBlockTr] = rule_info("HtmlBlockTr", "HtmlBlockOpenTr (HtmlBlockTr | !HtmlBlockCloseTr .)* HtmlBlockCloseTr")
  Rules[:_HtmlBlockOpenScript] = rule_info("HtmlBlockOpenScript", "\"<\" Spnl (\"script\" | \"SCRIPT\") Spnl HtmlAttribute* \">\"")
  Rules[:_HtmlBlockCloseScript] = rule_info("HtmlBlockCloseScript", "\"<\" Spnl \"/\" (\"script\" | \"SCRIPT\") Spnl \">\"")
  Rules[:_HtmlBlockScript] = rule_info("HtmlBlockScript", "HtmlBlockOpenScript (!HtmlBlockCloseScript .)* HtmlBlockCloseScript")
  Rules[:_HtmlBlockInTags] = rule_info("HtmlBlockInTags", "(HtmlBlockAddress | HtmlBlockBlockquote | HtmlBlockCenter | HtmlBlockDir | HtmlBlockDiv | HtmlBlockDl | HtmlBlockFieldset | HtmlBlockForm | HtmlBlockH1 | HtmlBlockH2 | HtmlBlockH3 | HtmlBlockH4 | HtmlBlockH5 | HtmlBlockH6 | HtmlBlockMenu | HtmlBlockNoframes | HtmlBlockNoscript | HtmlBlockOl | HtmlBlockP | HtmlBlockPre | HtmlBlockTable | HtmlBlockUl | HtmlBlockDd | HtmlBlockDt | HtmlBlockFrameset | HtmlBlockLi | HtmlBlockTbody | HtmlBlockTd | HtmlBlockTfoot | HtmlBlockTh | HtmlBlockThead | HtmlBlockTr | HtmlBlockScript)")
  Rules[:_HtmlBlock] = rule_info("HtmlBlock", "< (HtmlBlockInTags | HtmlComment | HtmlBlockSelfClosing) > BlankLine+ {   raise 'if (extension(EXT_FILTER_HTML)) {                     $$ = mk_list(LIST, NULL);                 } else {                     $$ = mk_str(yytext);                     $$->key = HTMLBLOCK;                 }'             }")
  Rules[:_HtmlBlockSelfClosing] = rule_info("HtmlBlockSelfClosing", "\"<\" Spnl HtmlBlockType Spnl HtmlAttribute* \"/\" Spnl \">\"")
  Rules[:_HtmlBlockType] = rule_info("HtmlBlockType", "(\"address\" | \"blockquote\" | \"center\" | \"dir\" | \"div\" | \"dl\" | \"fieldset\" | \"form\" | \"h1\" | \"h2\" | \"h3\" | \"h4\" | \"h5\" | \"h6\" | \"hr\" | \"isindex\" | \"menu\" | \"noframes\" | \"noscript\" | \"ol\" | \"p\" | \"pre\" | \"table\" | \"ul\" | \"dd\" | \"dt\" | \"frameset\" | \"li\" | \"tbody\" | \"td\" | \"tfoot\" | \"th\" | \"thead\" | \"tr\" | \"script\" | \"ADDRESS\" | \"BLOCKQUOTE\" | \"CENTER\" | \"DIR\" | \"DIV\" | \"DL\" | \"FIELDSET\" | \"FORM\" | \"H1\" | \"H2\" | \"H3\" | \"H4\" | \"H5\" | \"H6\" | \"HR\" | \"ISINDEX\" | \"MENU\" | \"NOFRAMES\" | \"NOSCRIPT\" | \"OL\" | \"P\" | \"PRE\" | \"TABLE\" | \"UL\" | \"DD\" | \"DT\" | \"FRAMESET\" | \"LI\" | \"TBODY\" | \"TD\" | \"TFOOT\" | \"TH\" | \"THEAD\" | \"TR\" | \"SCRIPT\")")
  Rules[:_StyleOpen] = rule_info("StyleOpen", "\"<\" Spnl (\"style\" | \"STYLE\") Spnl HtmlAttribute* \">\"")
  Rules[:_StyleClose] = rule_info("StyleClose", "\"<\" Spnl \"/\" (\"style\" | \"STYLE\") Spnl \">\"")
  Rules[:_InStyleTags] = rule_info("InStyleTags", "StyleOpen (!StyleClose .)* StyleClose")
  Rules[:_StyleBlock] = rule_info("StyleBlock", "< InStyleTags > BlankLine* {   raise 'if (extension(EXT_FILTER_STYLES)) {                         $$ = mk_list(LIST, NULL);                     } else {                         $$ = mk_str(yytext);                         $$->key = HTMLBLOCK;                     }'                 }")
  Rules[:_Inlines] = rule_info("Inlines", "StartList:a (!Endline Inline:i { a = [i, a] } | Endline:c &Inline { raise \" a = cons(c, a); \" })+ Endline? { [:LIST, a] }")
  Rules[:_Inline] = rule_info("Inline", "(Str | Endline | UlOrStarLine | Space | Strong | Emph | Image | Link | NoteReference | InlineNote | Code | RawHtml | Entity | EscapedChar | Smart | Symbol)")
  Rules[:_Space] = rule_info("Space", "Spacechar+ { '$$ = mk_str(\" \");           $$->key = SPACE;';           \" \" }")
  Rules[:_Str] = rule_info("Str", "StartList:a < NormalChar+ > { a = [text, a] } (StrChunk { raise \" a = cons($$, a); \" })* { !a[0] ? a : [:LIST, a] }")
  Rules[:_StrChunk] = rule_info("StrChunk", "(< (NormalChar | \"_\"+ &Alphanumeric)+ > { raise \" $$ = mk_str(yytext); \" } | AposChunk)")
  Rules[:_AposChunk] = rule_info("AposChunk", "&{  extension(:EXT_SMART)  } \"'\" &Alphanumeric { raise \" $$ = mk_element(APOSTROPHE); \" }")
  Rules[:_EscapedChar] = rule_info("EscapedChar", "\"\\\\\" !Newline < /[-\\\\`|*_{}[\\]()\#+.!><]/ > { raise \" $$ = mk_str(yytext); \" }")
  Rules[:_Entity] = rule_info("Entity", "(HexEntity | DecEntity | CharEntity) { raise \" $$ = mk_str(yytext); $$->key = HTML; \" }")
  Rules[:_Endline] = rule_info("Endline", "(LineBreak | TerminalEndline | NormalEndline)")
  Rules[:_NormalEndline] = rule_info("NormalEndline", "Sp Newline !BlankLine !\">\" !AtxStart !(Line (\"===\" \"=\"* | \"---\" \"-\"*) Newline) { raise '$$ = mk_str(\"\\n\");                     $$->key = SPACE;' }")
  Rules[:_TerminalEndline] = rule_info("TerminalEndline", "Sp Newline Eof { raise \" $$ = NULL; \" }")
  Rules[:_LineBreak] = rule_info("LineBreak", "\"  \" NormalEndline { raise \" $$ = mk_element(LINEBREAK); \" }")
  Rules[:_Symbol] = rule_info("Symbol", "< SpecialChar > { raise \" $$ = mk_str(yytext); \" }")
  Rules[:_UlOrStarLine] = rule_info("UlOrStarLine", "(UlLine | StarLine) { raise \" $$ = mk_str(yytext); \" }")
  Rules[:_StarLine] = rule_info("StarLine", "(< \"****\" \"*\"* > | < Spacechar \"*\"+ &Spacechar >)")
  Rules[:_UlLine] = rule_info("UlLine", "(< \"____\" \"_\"* > | < Spacechar \"_\"+ &Spacechar >)")
  Rules[:_Emph] = rule_info("Emph", "(EmphStar | EmphUl)")
  Rules[:_OneStarOpen] = rule_info("OneStarOpen", "!StarLine \"*\" !Spacechar !Newline")
  Rules[:_OneStarClose] = rule_info("OneStarClose", "!Spacechar !Newline a:inline !StrongStar \"*\" { raise \" $$ = a; \" }")
  Rules[:_EmphStar] = rule_info("EmphStar", "OneStarOpen StartList:a (!OneStarClose Inline { raise \" a = cons($$, a); \" })* OneStarClose { raise \" a = cons($$, a); \" } { raise \" $$ = mk_list(EMPH, a); \" }")
  Rules[:_OneUlOpen] = rule_info("OneUlOpen", "!UlLine \"_\" !Spacechar !Newline")
  Rules[:_OneUlClose] = rule_info("OneUlClose", "!Spacechar !Newline a:inline !StrongUl \"_\" !Alphanumeric { raise \" $$ = a; \" }")
  Rules[:_EmphUl] = rule_info("EmphUl", "OneUlOpen StartList:a (!OneUlClose Inline { raise \" a = cons($$, a); \" })* OneUlClose { raise \" a = cons($$, a); \" } { raise \" $$ = mk_list(EMPH, a); \" }")
  Rules[:_Strong] = rule_info("Strong", "(StrongStar | StrongUl)")
  Rules[:_TwoStarOpen] = rule_info("TwoStarOpen", "!StarLine \"**\" !Spacechar !Newline")
  Rules[:_TwoStarClose] = rule_info("TwoStarClose", "!Spacechar !Newline a:inline \"**\" { raise \" $$ = a; \" }")
  Rules[:_StrongStar] = rule_info("StrongStar", "TwoStarOpen StartList:a (!TwoStarClose Inline { raise \" a = cons($$, a); \" })* TwoStarClose { raise \" a = cons($$, a); \" } { raise \" $$ = mk_list(STRONG, a); \" }")
  Rules[:_TwoUlOpen] = rule_info("TwoUlOpen", "!UlLine \"__\" !Spacechar !Newline")
  Rules[:_TwoUlClose] = rule_info("TwoUlClose", "!Spacechar !Newline a:inline \"__\" !Alphanumeric { raise \" $$ = a; \" }")
  Rules[:_StrongUl] = rule_info("StrongUl", "TwoUlOpen StartList:a (!TwoUlClose Inline { raise \" a = cons($$, a); \" })* TwoUlClose { raise \" a = cons($$, a); \" } { raise \" $$ = mk_list(STRONG, a); \" }")
  Rules[:_Image] = rule_info("Image", "\"!\" (ExplicitLink | ReferenceLink) { raise 'if ($$->key == LINK) {               $$->key = IMAGE;           } else {               element *result;               result = $$;               $$->children = cons(mk_str(\"!\"), result->children);           } ' }")
  Rules[:_Link] = rule_info("Link", "(ExplicitLink | ReferenceLink | AutoLink)")
  Rules[:_ReferenceLink] = rule_info("ReferenceLink", "(ReferenceLinkDouble | ReferenceLinkSingle)")
  Rules[:_ReferenceLinkDouble] = rule_info("ReferenceLinkDouble", "Label:a < Spnl > !\"[]\" Label:b {   raise 'link match;                            if (find_reference(&match, b->children)) {                                $$ = mk_link(a->children, match.url, match.title);                                free(a);                                free_element_list(b);                            } else {                                element *result;                                result = mk_element(LIST);                                result->children = cons(mk_str(\"[\"), cons(a, cons(mk_str(\"]\"), cons(mk_str(yytext),                                                    cons(mk_str(\"[\"), cons(b, mk_str(\"]\")))))));                                $$ = result;                            }                            '                        }")
  Rules[:_ReferenceLinkSingle] = rule_info("ReferenceLinkSingle", "Label:a < (Spnl \"[]\")? > {   raise 'link match;                            if (find_reference(&match, a->children)) {                                $$ = mk_link(a->children, match.url, match.title);                                free(a);                            }                            else {                                element *result;                                result = mk_element(LIST);                                result->children = cons(mk_str(\"[\"), cons(a, cons(mk_str(\"]\"), mk_str(yytext))));                                $$ = result;                            }'                        }")
  Rules[:_ExplicitLink] = rule_info("ExplicitLink", "Label:l Spnl \"(\" Sp Source:s Spnl Title:t Sp \")\" { raise '$$ = mk_link(l->children, s->contents.str, t->contents.str);                   free_element(s);                   free_element(t);                   free(l);' }")
  Rules[:_Source] = rule_info("Source", "(\"<\" < SourceContents > \">\" | < SourceContents >) { raise \" $$ = mk_str(yytext); \" }")
  Rules[:_SourceContents] = rule_info("SourceContents", "(((!\"(\" !\")\" !\">\" Nonspacechar)+ | \"(\" SourceContents \")\")* | \"\")")
  Rules[:_Title] = rule_info("Title", "(TitleSingle | TitleDouble | < \"\" >) { raise \" $$ = mk_str(yytext); \" }")
  Rules[:_TitleSingle] = rule_info("TitleSingle", "\"'\" < (!(\"'\" Sp (\")\" | Newline)) .)* > \"'\"")
  Rules[:_TitleDouble] = rule_info("TitleDouble", "\"\\\"\" < (!(\"\\\"\" Sp (\")\" | Newline)) .)* > \"\\\"\"")
  Rules[:_AutoLink] = rule_info("AutoLink", "(AutoLinkUrl | AutoLinkEmail)")
  Rules[:_AutoLinkUrl] = rule_info("AutoLinkUrl", "\"<\" < /[A-Za-z]+/ \"://\" (!Newline !\">\" .)+ > \">\" { raise \"   $$ = mk_link(mk_str(yytext), yytext, \"\"); \" }")
  Rules[:_AutoLinkEmail] = rule_info("AutoLinkEmail", "\"<\" < /[-A-Za-z0-9+_]+/ \"@\" (!Newline !\">\" .)+ > \">\" {  raise ' char *mailto = malloc(strlen(yytext) + 8);                     sprintf(mailto, \"mailto:%s\", yytext);                     $$ = mk_link(mk_str(yytext), mailto, \"\");                     free(mailto);'                 }")
  Rules[:_Reference] = rule_info("Reference", "NonindentSpace !\"[]\" Label:l \":\" Spnl RefSrc:s RefTitle:t BlankLine+ { raise ' $$ = mk_link(l->children, s->contents.str, t->contents.str);               free_element(s);               free_element(t);               free(l);               $$->key = REFERENCE; '}")
  Rules[:_Label] = rule_info("Label", "\"[\" (!\"^\" &{ raise \" extension(EXT_NOTES) \" } | &. &{ raise \"!extension(EXT_NOTES) \" }) StartList:a (!\"]\" Inline { raise \" a = cons($$, a); \" })* \"]\" { raise \" $$ = mk_list(LIST, a); \" }")
  Rules[:_RefSrc] = rule_info("RefSrc", "< Nonspacechar+ > { raise '$$ = mk_str(yytext);             $$->key = HTML;' }")
  Rules[:_RefTitle] = rule_info("RefTitle", "(RefTitleSingle | RefTitleDouble | RefTitleParens | EmptyTitle) { raise \" $$ = mk_str(yytext); \" }")
  Rules[:_EmptyTitle] = rule_info("EmptyTitle", "< \"\" >")
  Rules[:_RefTitleSingle] = rule_info("RefTitleSingle", "Spnl \"'\" < (!(\"'\" Sp Newline | Newline) .)* > \"'\"")
  Rules[:_RefTitleDouble] = rule_info("RefTitleDouble", "Spnl \"\\\"\" < (!(\"\\\"\" Sp Newline | Newline) .)* > \"\\\"\"")
  Rules[:_RefTitleParens] = rule_info("RefTitleParens", "Spnl \"(\" < (!(\")\" Sp Newline | Newline) .)* > \")\"")
  Rules[:_References] = rule_info("References", "StartList:a (b:reference { raise \" a = cons(b, a); \" } | SkipBlock)* { raise \" references = reverse(a); \" }")
  Rules[:_Ticks1] = rule_info("Ticks1", "\"`\" !\"`\"")
  Rules[:_Ticks2] = rule_info("Ticks2", "\"``\" !\"`\"")
  Rules[:_Ticks3] = rule_info("Ticks3", "\"```\" !\"`\"")
  Rules[:_Ticks4] = rule_info("Ticks4", "\"````\" !\"`\"")
  Rules[:_Ticks5] = rule_info("Ticks5", "\"`````\" !\"`\"")
  Rules[:_Code] = rule_info("Code", "(Ticks1 Sp < ((!\"`\" Nonspacechar)+ | !Ticks1 \"`\"+ | !(Sp Ticks1) (Spacechar | Newline !BlankLine))+ > Sp Ticks1 | Ticks2 Sp < ((!\"`\" Nonspacechar)+ | !Ticks2 \"`\"+ | !(Sp Ticks2) (Spacechar | Newline !BlankLine))+ > Sp Ticks2 | Ticks3 Sp < ((!\"`\" Nonspacechar)+ | !Ticks3 \"`\"+ | !(Sp Ticks3) (Spacechar | Newline !BlankLine))+ > Sp Ticks3 | Ticks4 Sp < ((!\"`\" Nonspacechar)+ | !Ticks4 \"`\"+ | !(Sp Ticks4) (Spacechar | Newline !BlankLine))+ > Sp Ticks4 | Ticks5 Sp < ((!\"`\" Nonspacechar)+ | !Ticks5 \"`\"+ | !(Sp Ticks5) (Spacechar | Newline !BlankLine))+ > Sp Ticks5) { raise \" $$ = mk_str(yytext); $$->key = CODE; \" }")
  Rules[:_RawHtml] = rule_info("RawHtml", "< (HtmlComment | HtmlBlockScript | HtmlTag) > {   raise 'if (extension(EXT_FILTER_HTML)) {                     $$ = mk_list(LIST, NULL);                 } else {                     $$ = mk_str(yytext);                     $$->key = HTML;                 }'             }")
  Rules[:_BlankLine] = rule_info("BlankLine", "Sp Newline")
  Rules[:_Quoted] = rule_info("Quoted", "(\"\\\"\" (!\"\\\"\" .)* \"\\\"\" | \"'\" (!\"'\" .)* \"'\")")
  Rules[:_HtmlAttribute] = rule_info("HtmlAttribute", "(AlphanumericAscii | \"-\")+ Spnl (\"=\" Spnl (Quoted | (!\">\" Nonspacechar)+))? Spnl")
  Rules[:_HtmlComment] = rule_info("HtmlComment", "\"<!--\" (!\"-->\" .)* \"-->\"")
  Rules[:_HtmlTag] = rule_info("HtmlTag", "\"<\" Spnl \"/\"? AlphanumericAscii+ Spnl HtmlAttribute* \"/\"? Spnl \">\"")
  Rules[:_Eof] = rule_info("Eof", "!.")
  Rules[:_Spacechar] = rule_info("Spacechar", "(\" \" | \"\\t\")")
  Rules[:_Nonspacechar] = rule_info("Nonspacechar", "!Spacechar !Newline .")
  Rules[:_Newline] = rule_info("Newline", "(\"\\n\" | \"\" \"\\n\"?)")
  Rules[:_Sp] = rule_info("Sp", "Spacechar*")
  Rules[:_Spnl] = rule_info("Spnl", "Sp (Newline Sp)?")
  Rules[:_SpecialChar] = rule_info("SpecialChar", "(\"*\" | \"_\" | \"`\" | \"&\" | \"[\" | \"]\" | \"(\" | \")\" | \"<\" | \"!\" | \"\#\" | \"\\\\\" | \"'\" | \"\\\"\" | ExtendedSpecialChar)")
  Rules[:_NormalChar] = rule_info("NormalChar", "!(SpecialChar | Spacechar | Newline) .")
  Rules[:_NonAlphanumeric] = rule_info("NonAlphanumeric", "/[\\000-\\057\\072-\\100\\133-\\140\\173-\\177]/")
  Rules[:_Alphanumeric] = rule_info("Alphanumeric", "(/[0-9A-Za-z]/ | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \"\" | \" \" | \"¡\" | \"¢\" | \"£\" | \"¤\" | \"¥\" | \"¦\" | \"§\" | \"¨\" | \"©\" | \"ª\" | \"«\" | \"¬\" | \"­\" | \"®\" | \"¯\" | \"°\" | \"±\" | \"²\" | \"³\" | \"´\" | \"µ\" | \"¶\" | \"·\" | \"¸\" | \"¹\" | \"º\" | \"»\" | \"¼\" | \"½\" | \"¾\" | \"¿\" | \"À\" | \"Á\" | \"Â\" | \"Ã\" | \"Ä\" | \"Å\" | \"Æ\" | \"Ç\" | \"È\" | \"É\" | \"Ê\" | \"Ë\" | \"Ì\" | \"Í\" | \"Î\" | \"Ï\" | \"Ð\" | \"Ñ\" | \"Ò\" | \"Ó\" | \"Ô\" | \"Õ\" | \"Ö\" | \"×\" | \"Ø\" | \"Ù\" | \"Ú\" | \"Û\" | \"Ü\" | \"Ý\" | \"Þ\" | \"ß\" | \"à\" | \"á\" | \"â\" | \"ã\" | \"ä\" | \"å\" | \"æ\" | \"ç\" | \"è\" | \"é\" | \"ê\" | \"ë\" | \"ì\" | \"í\" | \"î\" | \"ï\" | \"ð\" | \"ñ\" | \"ò\" | \"ó\" | \"ô\" | \"õ\" | \"ö\" | \"÷\" | \"ø\" | \"ù\" | \"ú\" | \"û\" | \"ü\" | \"ý\" | \"þ\" | \"ÿ\")")
  Rules[:_AlphanumericAscii] = rule_info("AlphanumericAscii", "/[A-Za-z0-9]/")
  Rules[:_Digit] = rule_info("Digit", "[0-9]")
  Rules[:_BOM] = rule_info("BOM", "\"ï»¿\"")
  Rules[:_HexEntity] = rule_info("HexEntity", "< \"&\" \"\#\" /[Xx]/ /[0-9a-fA-F]+/ \";\" >")
  Rules[:_DecEntity] = rule_info("DecEntity", "< \"&\" \"\#\" /[0-9]+/ \";\" >")
  Rules[:_CharEntity] = rule_info("CharEntity", "< \"&\" /[A-Za-z0-9]+/ \";\" >")
  Rules[:_NonindentSpace] = rule_info("NonindentSpace", "(\"   \" | \"  \" | \" \" | \"\")")
  Rules[:_Indent] = rule_info("Indent", "(\"\\t\" | \"    \")")
  Rules[:_IndentedLine] = rule_info("IndentedLine", "Indent Line")
  Rules[:_OptionallyIndentedLine] = rule_info("OptionallyIndentedLine", "Indent? Line")
  Rules[:_StartList] = rule_info("StartList", "&. { nil }")
  Rules[:_Line] = rule_info("Line", "RawLine { raise \" $$ = mk_str(yytext); \" }")
  Rules[:_RawLine] = rule_info("RawLine", "(< (!\"\" !\"\\n\" .)* Newline > | < .+ > Eof)")
  Rules[:_SkipBlock] = rule_info("SkipBlock", "((!BlankLine RawLine)+ BlankLine* | BlankLine+)")
  Rules[:_ExtendedSpecialChar] = rule_info("ExtendedSpecialChar", "(&{ extension(:EXT_SMART) } (\".\" | \"-\" | \"'\" | \"\\\"\") | &{ extension(:EXT_NOTES) } \"^\")")
  Rules[:_Smart] = rule_info("Smart", "&{  extension(:EXT_SMART)  } (Ellipsis | Dash | SingleQuoted | DoubleQuoted | Apostrophe)")
  Rules[:_Apostrophe] = rule_info("Apostrophe", "\"'\" { raise \" $$ = mk_element(APOSTROPHE); \" }")
  Rules[:_Ellipsis] = rule_info("Ellipsis", "(\"...\" | \". . .\") { raise \" $$ = mk_element(ELLIPSIS); \" }")
  Rules[:_Dash] = rule_info("Dash", "(EmDash | EnDash)")
  Rules[:_EnDash] = rule_info("EnDash", "\"-\" &Digit { raise \" $$ = mk_element(ENDASH); \" }")
  Rules[:_EmDash] = rule_info("EmDash", "(\"---\" | \"--\") { raise \" $$ = mk_element(EMDASH); \" }")
  Rules[:_SingleQuoteStart] = rule_info("SingleQuoteStart", "\"'\" !(Spacechar | Newline)")
  Rules[:_SingleQuoteEnd] = rule_info("SingleQuoteEnd", "\"'\" !Alphanumeric")
  Rules[:_SingleQuoted] = rule_info("SingleQuoted", "SingleQuoteStart StartList:a (!SingleQuoteEnd b:inline { raise \" a = cons(b, a); \" })+ SingleQuoteEnd { raise \" $$ = mk_list(SINGLEQUOTED, a); \" }")
  Rules[:_DoubleQuoteStart] = rule_info("DoubleQuoteStart", "\"\\\"\"")
  Rules[:_DoubleQuoteEnd] = rule_info("DoubleQuoteEnd", "\"\\\"\"")
  Rules[:_DoubleQuoted] = rule_info("DoubleQuoted", "DoubleQuoteStart StartList:a (!DoubleQuoteEnd b:inline { raise \" a = cons(b, a); \" })+ DoubleQuoteEnd { raise \" $$ = mk_list(DOUBLEQUOTED, a); \" }")
  Rules[:_NoteReference] = rule_info("NoteReference", "&{ extension(:EXT_NOTES) } RawNoteReference:ref {   raise 'element *match;                     if (find_note(&match, ref->contents.str)) {                         $$ = mk_element(NOTE);                         assert(match->children != NULL);                         $$->children = match->children;                         $$->contents.str = 0;                     } else {                         char *s;                         s = malloc(strlen(ref->contents.str) + 4);                         sprintf(s, \"[^%s]\", ref->contents.str);                         $$ = mk_str(s);                         free(s);                     }'                 }")
  Rules[:_RawNoteReference] = rule_info("RawNoteReference", "\"[^\" < (!Newline !\"]\" .)+ > \"]\" { raise \" $$ = mk_str(yytext); \" }")
  Rules[:_Note] = rule_info("Note", "&{ extension(:EXT_NOTES) } NonindentSpace ref:rawNoteReference \":\" Sp StartList:a RawNoteBlock { raise \" a = cons($$, a); \" } (&Indent RawNoteBlock { raise \" a = cons($$, a); \" })* {   raise '$$ = mk_list(NOTE, a);                     $$->contents.str = strdup(ref->contents.str); '                 }")
  Rules[:_InlineNote] = rule_info("InlineNote", "&{ extension(:EXT_NOTES) } \"^[\" StartList:a (!\"]\" Inline { raise \" a = cons($$, a); \" })+ \"]\" { raise '$$ = mk_list(NOTE, a);                   $$->contents.str = 0; '}")
  Rules[:_Notes] = rule_info("Notes", "StartList:a (b:note { raise \" a = cons(b, a); \" } | SkipBlock)* { raise \" notes = reverse(a); \" }")
  Rules[:_RawNoteBlock] = rule_info("RawNoteBlock", "StartList:a (!BlankLine OptionallyIndentedLine { raise \" a = cons($$, a); \" })+ < BlankLine* > { raise \" a = cons(mk_str(yytext), a); \" } {   raise '$$ = mk_str_from_list(a, true);                     $$->key = RAW; '                 }")
end
