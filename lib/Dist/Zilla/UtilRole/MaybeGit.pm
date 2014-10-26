use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Dist::Zilla::UtilRole::MaybeGit;

our $VERSION = '0.004002';

# ABSTRACT: A role to make adding a ->git method easy, and low-complexity

# AUTHORITY

use Moose::Role qw( with has );
with 'Dist::Zilla::UtilRole::MaybeZilla';

has 'git' => ( is => ro =>, isa => Object =>, lazy_build => 1 );

sub _build_git {
  my ($self) = @_;
  require Dist::Zilla::Util::Git::Wrapper;
  return Dist::Zilla::Util::Git::Wrapper->new( zilla => $self->zilla );
}

no Moose::Role;
1;

