use v6;
unit class Data::Section::Simple;

has $.package; # TODO

multi get-data-section() is export {
    my $content = CALLER::<$=finish>;
    $?CLASS!parse($content);
}
multi get-data-section(Str:D $name) {
    my $content = CALLER::<$=finish>;
    $?CLASS!parse($content, $name);
}
multi method get-data-section() {
    my $content = CALLER::<$=finish>;
    self!parse($content);
}
multi method get-data-section(Str:D $name) {
    my $content = CALLER::<$=finish>;
    self!parse($content, $name);
}

method !parse($content, Str $name?) {
    my @data = $content.split(/\r?\n^^ '@@' \s+ (.+?) \s* \r?\n/, :all);
    @data.shift;
    my %all = do for @data -> $/, $c {
        $/[0].Str => $c;
    };
    $name ?? %all{$name} !! %all;
}

=begin pod

=head1 NAME

Data::Section::Simple - Read data from =finish

=head1 SYNOPSIS

=begin code

  # Functional interface
  use Data::Section::Simple;
  my %all = get-data-section;
  my $foo = get-data-section('foo.html');

  # OO interface
  need Data::Section::Simple;
  my $render = Data::Section::Simple.new;
  my %all = $render.get-data-section;
  my $foo = $render.get-data-section('foo.html');

  =finish

  @@ foo.html
  <html>
   <body>Hello</body>
  </html>

  @@ bar.tt
  [% IF true %]
    Foo
  [% END %]

=end code

=head1 DESCRIPTION

Data::Section::Simple is a simple module to extract data from
C<=finish> section of the file.

This is perl5 Data::Section::Simple port.

=head1 AUTHOR

Shoichi Kaji <skaji@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2015 Shoichi Kaji

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=head1 ORIGINAL COPYRIGHT AND LICENSE

  Copyright 2010- Tatsuhiko Miyagawa

  The code to read DATA section is based on Mojo::Command get_all_data:
  Copyright 2008-2010 Sebastian Riedel

  This library is free software; you can redistribute it and/or modify
  it under the same terms as Perl itself.

=end pod