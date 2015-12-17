=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.css )

Rails.application.config.assets.precompile += %w( animate.css )
Rails.application.config.assets.precompile += %w( style.css )
Rails.application.config.assets.precompile += %w( font-awesome.min.css )

Rails.application.config.assets.precompile += %w( plugins/slimscroll/jquery.slimscroll.min.js )
Rails.application.config.assets.precompile += %w( plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css )
Rails.application.config.assets.precompile += %w( plugins/iCheck/icheck.min.js )
Rails.application.config.assets.precompile += %w( plugins/summernote/summernote.css )
Rails.application.config.assets.precompile += %w( plugins/summernote/summernote-bs3.css )
Rails.application.config.assets.precompile += %w( plugins/summernote/summernote.min.js )
Rails.application.config.assets.precompile += %w( fnf.js )
Rails.application.config.assets.precompile += %w( plugins/pace/pace.min.js )

Rails.application.config.assets.precompile += %w( plugins/slick/slick.css )
Rails.application.config.assets.precompile += %w( plugins/slick/slick-theme.css )
Rails.application.config.assets.precompile += %w( plugins/slick/slick.min.js )

Rails.application.config.assets.precompile += %w( plugins/toastr/toastr.min.js )
Rails.application.config.assets.precompile += %w( plugins/toastr/toastr.min.css )

Rails.application.config.assets.precompile += %w( plugins/morris/raphael-2.1.0.min.js )
Rails.application.config.assets.precompile += %w( plugins/morris/morris.js )

Rails.application.config.assets.precompile += %w( plugins/iCheck/custom.css )

Rails.application.config.assets.precompile += %w( plugins/datapicker/datepicker3.css )
Rails.application.config.assets.precompile += %w( plugins/datapicker/bootstrap-datepicker.js )

Rails.application.config.assets.precompile += %w( plugins/validate/jquery.validate.min.js )