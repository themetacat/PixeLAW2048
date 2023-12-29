start_core:
	docker compose up --force-recreate -d

stop_core:
	docker compose down

build_apps:
	sozo build --manifest-path ./brc2048/Scarb.toml;
	sozo build --manifest-path ./pix2048/Scarb.toml;

migrate_apps:
	cd brc2048; scarb run ready_for_deployment;
	sozo migrate --name pixelaw --manifest-path ./brc2048/Scarb.toml;
	sozo migrate --name pixelaw --manifest-path ./pix2048/Scarb.toml;

initialize_apps:
	cd brc2048; scarb run initialize;
	cd pix2048; scarb run initialize;

upload_manifests:
	cd brc2048; scarb run upload_manifest;
	cd pix2048; scarb run upload_manifest;

start:
	# make start_core;
	make build_apps;
	make migrate_apps;
	make initialize_apps;
	make upload_manifests;

stop: stop_core
