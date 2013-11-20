program niceParser;

type
  adress = ^string;
  adress_book = array['!'..'~'] of adress;
  lines = ^element;
  element = record
    value : string;
    next : lines;
  end;

function is_empty(s:string):boolean;
  begin 
    if length(s) = 0 then
      is_empty := true
    else
      is_empty := false;
  end;

procedure init_adress_book(var dictionary:adress_book);
  var
    i:char;
  begin
    for i := '!' to '~' do begin
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
      dictionary[ in_str[1] ] := p;
      readln(in_str);
    end;
  end;

function changer(const word_in:string; dictionary:adress_book ):string;
  var
    word_out : string;
    i : integer;
  begin
    word_out := '';
    for i := 1 to length(word_in) do
      if dictionary[word_in[i]] = Nil then
        word_out := concat( word_out, word_in[i] )
      else
        word_out := concat( word_out, dictionary[word_in[i]]^ );
    changer := word_out;
  end;

function get_fixed_text() : lines;
  var 
    start : lines;
    current : lines;
    worker : lines;
    in_str : string;
  begin 
    start := Nil;
    current := Nil;
    readln(in_str);
    while length(in_str) <> 0 do begin
      worker := new(lines);
      worker^.next := Nil;
      worker^.value := in_str;
      if start = Nil then begin
        start := worker;
        current := worker;
      end else begin
        current^.next := worker;
        current := worker;
      end;
      readln(in_str);
    end;
    get_fixed_text := start;
  end;

procedure write_fixed_text( fixed_text:lines );
  begin
    while fixed_text <> Nil do begin
      writeln(fixed_text^.value);
      fixed_text := fixed_text^.next;
    end;
  end;

procedure write_output(const in_str:string; dictionary:adress_book);
  var
    i : integer;
  begin
    for i := 1 to length(in_str) do
      if dictionary[in_str[i]] <> Nil then
        writeln(dictionary[in_str[i]]^);
  end;

var
  iter_num, k : integer;
  first_dictionary, second_dictionary : adress_book;
  axiom : string;
  prefix, sufix : lines;

begin
  init_adress_book(first_dictionary);
  init_adress_book(second_dictionary);
  readln(iter_num);
  readln(axiom);
  get_rules(first_dictionary);
  prefix := get_fixed_text();
  get_rules(second_dictionary);
  sufix := get_fixed_text();
  for k := 1 to iter_num do
    axiom := changer( axiom, first_dictionary );
  write_fixed_text(prefix);
  write_output(axiom, second_dictionary);
  write_fixed_text(sufix);
end.