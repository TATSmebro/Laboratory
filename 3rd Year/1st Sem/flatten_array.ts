export function flatten(list: any[]): any[]{
    let ret: any[] = [];

    for(const element of list){
        if(element == null){
            continue;
        }
        if(!Array.isArray(element)){
            ret.push(element);
        }
        else{
            ret = ret.concat(flatten(element));
        }
    }

    return ret;
}
  

