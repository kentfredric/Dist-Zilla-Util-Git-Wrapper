
use strict;
use warnings;

use Test::More;

# FILENAME: basic.t
# CREATED: 12/07/13 06:28:57 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Simple functionality test.

use Path::Tiny qw(path);

my $tempdir = Path::Tiny->tempdir;
my $repo    = $tempdir->child('git-repo');
$repo->mkpath;
my $file    = $repo->child('testfile');

use Dist::Zilla::Util::Git::Wrapper;
use Git::Wrapper;
use Test::Fatal qw( exception );

local $ENV{GIT_AUTHOR_NAME} = 'A. U. Thor';
local $ENV{GIT_AUTHOR_EMAIL} = 'author@example.org';

my $wrapper = Dist::Zilla::Util::Git::Wrapper->new(
    git => Git::Wrapper->new( $tempdir->child('git-repo') )
);

sub report_ctx {
    my ( @lines ) = @_;
    note explain \@lines;
}

report_ctx( $wrapper->init()  );
report_ctx( $file->touch );
report_ctx( $wrapper->add('testfile') );
report_ctx( $wrapper->commit('-m', 'Test Commit' ) );
pass('Git::Wrapper methods executed without failure');

my $ex = exception {
    $wrapper->method_that_does_not_exist;
};
isnt( $ex, undef, 'method_that_does_not_exist failed' );
like( $ex, qr/ is not a git command./ , 'Exception is relevant' );
done_testing;


