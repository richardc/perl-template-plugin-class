use strict;
use Module::Build;

Module::Build
  ->new( module_name => "Template::Plugin::Class",
         license     => 'perl',
         build_requires => {
             'Test::More' => 0,
         },
         requires    => {
             'Template' => 0,
         },
       )
  ->create_build_script;
