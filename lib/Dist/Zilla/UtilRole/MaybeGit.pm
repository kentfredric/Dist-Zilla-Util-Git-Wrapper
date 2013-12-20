use strict;
use warnings;
use utf8;

package Dist::Zilla::UtilRole::MaybeGit;
BEGIN {
  $Dist::Zilla::UtilRole::MaybeGit::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::UtilRole::MaybeGit::VERSION = '0.003000';
}

# ABSTRACT: A role to make adding a ->git method easy, and low-complexity

use Moose::Role;
with 'Dist::Zilla::UtilRole::MaybeZilla';

has 'git' => ( is => ro =>, isa => Object =>, lazy_build => 1 );

sub _build_git {
  my ($self) = @_;
  require Dist::Zilla::Util::Git::Wrapper;
  return Dist::Zilla::Util::Git::Wrapper->new( zilla => $self->zilla );
}

no Moose::Role;
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::UtilRole::MaybeGit - A role to make adding a ->git method easy, and low-complexity

=head1 VERSION

version 0.003000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
