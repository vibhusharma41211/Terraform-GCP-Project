resource google_storage_bucket bucket {
	  name = "automatically_created_bucket"
    location = "asia-south2"
    storage_class = "STANDARD"
    force_destroy = true
    uniform_bucket_level_access = true
}

#Storage_class, Force_destroy and uniform_bucket_level_access
