#!/usr/bin/perl
use strict;
use warnings;
use lib qw( t/lib lib extlib ../lib ../extlib );
use MT::Test::Tags;

# Register a lot of blogs.
require MT::Blog;
for my $i ( 3 .. 20 ) {
    next if MT::Blog->load($i);

    my $blog = MT::Blog->new();
    $blog->set_values(
        {   name         => 'Blog: ' . $i,
            site_url     => '/::/' . $i,
            archive_url  => '/::/blog' . $i . '/archives/',
            site_path    => 'site/',
            archive_path => 'site/archives/',
            archive_type => 'Individual,Monthly,Weekly,Daily,Category,Page',
            archive_type_preferred   => 'Individual',
            description              => 'Blog: ' . $i,
            custom_dynamic_templates => 'custom',
            convert_paras            => 1,
            allow_reg_comments       => 1,
            allow_unreg_comments     => 0,
            allow_pings              => 1,
            sort_order_posts         => 'descend',
            sort_order_comments      => 'ascend',
            remote_auth_token        => 'token',
            convert_paras_comments   => 1,
            google_api_key           => 'r9Vj5K8PsjEu+OMsNZ/EEKjWmbCeQAv1',
            cc_license =>
                'by-nc-sa http://creativecommons.org/licenses/by-nc-sa/2.0/ http://creativecommons.org/images/public/somerights20.gif',
            server_offset        => '-3.5',
            children_modified_on => '20000101000000',
            language             => 'en_us',
            file_extension       => 'html',
            theme_id             => 'classic_blog',
        }
    );
    $blog->id($i);
    $blog->class('blog');
    $blog->parent_id(2);
    $blog->commenter_authenticators('enabled_TypeKey');
    $blog->save() or die "Couldn't save blog: " . $i . $blog->errstr;
}

run_tests_by_data();

__DATA__
-
  name: Blogs lists some blogs specified by include_blogs and exclude_blogs.
  template: |
    <mt:Blogs include_blogs="1-20" exclude_blogs="1">
      <mt:BlogName>
    </mt:Blogs>
  expected: |
    Blog: 10
    Blog: 11
    Blog: 12
    Blog: 13
    Blog: 14
    Blog: 15
    Blog: 16
    Blog: 17
    Blog: 18
    Blog: 19
    Blog: 20
    Blog: 3
    Blog: 4
    Blog: 5
    Blog: 6
    Blog: 7
    Blog: 8
    Blog: 9
