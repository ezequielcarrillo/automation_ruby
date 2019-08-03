CREATE TABLE `actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

CREATE TABLE `component_automation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `component_rel_id` varchar(45) DEFAULT NULL,
  `element_rel_id` varchar(45) DEFAULT NULL,
  `operation_rel_id` varchar(45) DEFAULT NULL,
  `parameter_rel_id` varchar(45) DEFAULT NULL,
  `execution_order` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=latin1;

CREATE TABLE `component_parameters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `component_rel_id` varchar(45) DEFAULT NULL,
  `parameter_name` varchar(45) DEFAULT NULL,
  `parameter_value` varchar(45) DEFAULT NULL,
  `parameter_description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=latin1;

CREATE TABLE `components` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
  `object_name` varchar(45) DEFAULT NULL,
  `object_type` varchar(45) DEFAULT NULL,
  `created_at` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `parent_object_id` varchar(45) DEFAULT NULL,
  `object_description` varchar(45) DEFAULT NULL,
  `object_status` varchar(45) DEFAULT NULL,
  `object_script` longtext,
  `object_screenshot_name` varchar(45) DEFAULT NULL,
  `modified_by` varchar(45) DEFAULT NULL,
  `modified_at` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`object_id`),
  UNIQUE KEY `component_id_UNIQUE` (`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;

CREATE TABLE `keywords` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
  `object_name` varchar(45) DEFAULT NULL,
  `object_type` varchar(45) DEFAULT NULL,
  `created_at` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `parent_object_id` varchar(45) DEFAULT NULL,
  `object_description` varchar(45) DEFAULT NULL,
  `browser` varchar(45) DEFAULT NULL,
  `modified_by` varchar(45) DEFAULT NULL,
  `modified_at` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`object_id`),
  UNIQUE KEY `keywords_id_UNIQUE` (`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

CREATE TABLE `keywords_workflow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_rel_id` varchar(45) DEFAULT NULL,
  `component_rel_id` varchar(45) DEFAULT NULL,
  `execution_order` varchar(45) DEFAULT NULL,
  `param_id` varchar(45) DEFAULT NULL,
  `param_value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=313 DEFAULT CHARSET=latin1;

CREATE TABLE `object_properties` (
  `object_rel_id` int(11) NOT NULL,
  `object_tag` varchar(45) DEFAULT NULL,
  `object_type` varchar(45) DEFAULT NULL,
  `object_html_id` varchar(45) DEFAULT NULL,
  `object_html_class` varchar(45) DEFAULT NULL,
  `object_html_text` varchar(45) DEFAULT NULL,
  `object_html_name` varchar(45) DEFAULT NULL,
  `object_html_index` varchar(45) DEFAULT NULL,
  `object_html_xpath` varchar(45) DEFAULT NULL,
  `locator` varchar(45) DEFAULT NULL,
  `locator_value` varchar(45) DEFAULT NULL,
  `locator_parameter` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`object_rel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `objects` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
  `object_name` varchar(45) DEFAULT NULL,
  `object_type` varchar(45) DEFAULT NULL,
  `created_at` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `parent_object_id` varchar(45) DEFAULT NULL,
  `object_description` varchar(45) DEFAULT NULL,
  `object_status` varchar(45) DEFAULT NULL,
  `modified_by` varchar(45) DEFAULT NULL,
  `modified_at` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`object_id`),
  UNIQUE KEY `object_id_UNIQUE` (`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=latin1;

CREATE TABLE `requirements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_rel_id` varchar(45) DEFAULT NULL,
  `requirement` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_at` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `services` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
  `object_name` varchar(45) DEFAULT NULL,
  `object_type` varchar(45) DEFAULT NULL,
  `created_at` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `parent_object_id` varchar(45) DEFAULT NULL,
  `object_description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`object_id`),
  UNIQUE KEY `service_id_UNIQUE` (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `settings` (
  `object_id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `object_name` varchar(45) DEFAULT NULL,
  `object_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

CREATE TABLE `suite_dependencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suite_id` varchar(45) DEFAULT NULL,
  `test_rel_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

CREATE TABLE `suites` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
  `object_name` varchar(45) DEFAULT NULL,
  `object_type` varchar(45) DEFAULT NULL,
  `created_at` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `parent_object_id` varchar(45) DEFAULT NULL,
  `object_description` varchar(45) DEFAULT NULL,
  `modified_by` varchar(45) DEFAULT NULL,
  `modified_at` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`object_id`),
  UNIQUE KEY `suite_id_UNIQUE` (`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

CREATE TABLE `test_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_rel_id` varchar(45) DEFAULT NULL,
  `time_stamp` varchar(45) DEFAULT NULL,
  `executed_by` varchar(45) DEFAULT NULL,
  `result` varchar(45) DEFAULT NULL,
  `error_log` varchar(45) DEFAULT NULL,
  `suite_execution_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `test_keyword_workflow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_rel_id` varchar(45) DEFAULT NULL,
  `component_rel_id` varchar(45) DEFAULT NULL,
  `execution_order` varchar(45) DEFAULT NULL,
  `param_id` varchar(45) DEFAULT NULL,
  `param_value` varchar(45) DEFAULT NULL,
  `keyword_rel_id` varchar(45) DEFAULT NULL,
  `workflow_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1138 DEFAULT CHARSET=latin1;

CREATE TABLE `test_workflow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_rel_id` varchar(45) DEFAULT NULL,
  `component_rel_id` varchar(45) DEFAULT NULL,
  `execution_order` varchar(45) DEFAULT NULL,
  `param_id` varchar(45) DEFAULT NULL,
  `param_value` varchar(45) DEFAULT NULL,
  `keyword_rel_id` varchar(45) DEFAULT NULL,
  `keyword` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1302 DEFAULT CHARSET=latin1;

CREATE TABLE `tests` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
  `object_name` varchar(45) DEFAULT NULL,
  `object_type` varchar(45) DEFAULT NULL,
  `created_at` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `parent_object_id` varchar(45) DEFAULT NULL,
  `object_description` varchar(45) DEFAULT NULL,
  `browser` varchar(45) DEFAULT NULL,
  `modified_by` varchar(45) DEFAULT NULL,
  `modified_at` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`object_id`),
  UNIQUE KEY `test_id_UNIQUE` (`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;
