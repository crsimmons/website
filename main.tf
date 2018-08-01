resource "google_storage_bucket" "website" {
  name     = "www.colin-simmons.com"
  location = "US"

  website {
    main_page_suffix = "index.html"
  }
}

resource "google_storage_bucket_acl" "website-acl" {
  bucket = "${google_storage_bucket.website.name}"

  predefined_acl = "publicRead"
}

resource "google_storage_bucket_iam_member" "public-read" {
  bucket = "www.colin-simmons.com"
  role   = "roles/storage.objectViewer"
  member = "allUsers"

  depends_on = ["google_storage_bucket.website"]
}

resource "google_storage_bucket_object" "site" {
  name   = "index.html"
  source = "site/index.html"
  bucket = "${google_storage_bucket.website.name}"
}

resource "google_storage_bucket_object" "custom" {
  name         = "css/custom.css"
  source       = "site/css/custom.css"
  content_type = "text/css"
  bucket       = "${google_storage_bucket.website.name}"
}

resource "google_storage_bucket_object" "normalize" {
  name         = "css/normalize.css"
  source       = "site/css/normalize.css"
  content_type = "text/css"
  bucket       = "${google_storage_bucket.website.name}"
}

resource "google_storage_bucket_object" "skeleton" {
  name         = "css/skeleton.css"
  source       = "site/css/skeleton.css"
  content_type = "text/css"
  bucket       = "${google_storage_bucket.website.name}"
}

resource "google_storage_bucket_object" "favicon" {
  name   = "images/favicon.png"
  source = "site/images/favicon.png"
  bucket = "${google_storage_bucket.website.name}"
}
