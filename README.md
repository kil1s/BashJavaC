# JavaC

## manage

### create a workspace

```sh
mkdir ~/workspace
cd ~/workspace
git clone https://github.com/kil1s/JavaC.git
cd JavaC
```

### create a scope
```sh
git checkout -b ${scope}
```

### add a project
```sh
name="Example"
path="src/main/java/"
```

```sh
mkdir -p ../$name/$path
touch ../$name/$name.lipm
echo "" > ../$name/.env
echo "MAIN_PATH=$path" >> ../$name/.env
echo "NAME=$name" >> ../$name/.env
echo $name >> BashJavaC.lipm
```

## update/setup
```sh
./configure
```

### configure projects
```sh
bash build.sh
```

### build everything
```sh
bash super.sh
```
