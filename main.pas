program very_nice_parser_that_fits_in_88x88_textfile;

const
  FIRST_VIABLE_CHAR = '!';
  LAST_VIABLE_CHAR = '~';

type
  adress = ^string;
  adress_book = array[FIRST_VIABLE_CHAR..LAST_VIABLE_CHAR] of adress;

procedure init_adress_book(var dictionary:adress_book);
  var
    i:char;
  begin
    for i := FIRST_VIABLE_CHAR to LAST_VIABLE_CHAR do begin
      dictionary[i] := Nil;
    end;
  end;

procedure get_rules(var dictionary:adress_book);
  var
    in_str : string;
    p : adress;
  begin
    readln(in_str);
    while length(in_str) <> 0 do begin
      p := new(adress);
      p^ := copy(in_str, 2, length(in_str)-1);
      dictionary[in_str[1]] := p;
      readln(in_str);
    end;
  end;

function changer(const word_in:ansistring;
                   const dictionary:adress_book):ansistring;
  var
    word_out : ansistring;
    i : longint;
  begin
    word_out := '';
    for i := 1 to length(word_in) do
      if dictionary[word_in[i]] = Nil then
        word_out := word_out + word_in[i]
      else
        word_out := word_out + dictionary[word_in[i]]^;
    changer := word_out;
  end;

procedure rewrite_fixed_text();
  var 
    in_str : string;
  begin 
    readln(in_str);
    while length(in_str) <> 0 do begin
      writeln(in_str);
      readln(in_str);
    end;
  end;

procedure write_output(const in_str:ansistring; const dictionary:adress_book);
  var
    i : longint;
  begin
    for i := 1 to length(in_str) do
      if dictionary[in_str[i]] <> Nil then
        writeln(dictionary[in_str[i]]^);
  end;

var
  iter_num, k : longint;
  first_dictionary, second_dictionary : adress_book;
  axiom : ansistring;

begin
  init_adress_book(first_dictionary);
  init_adress_book(second_dictionary);
  readln(iter_num);
  readln(axiom);
  get_rules(first_dictionary);
  rewrite_fixed_text(); // process prefix
  get_rules(second_dictionary);
  for k := 1 to iter_num do
    axiom := changer(axiom, first_dictionary);
  write_output(axiom, second_dictionary);
  rewrite_fixed_text(); // process suffix
end.
